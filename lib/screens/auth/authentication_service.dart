import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/screens/login/phone_screen.dart';
import 'package:firebase_project/screens/login/verification_screen.dart';
import 'package:firebase_project/data/repository/auth_repository.dart';
import 'package:firebase_project/utils/common_widgets/dialog_components.dart';
import 'package:firebase_project/utils/constants/functions.dart';
import 'package:firebase_project/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:firebase_project/utils/local_storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login/login_controller.dart';
import 'package:dio/dio.dart' as dio;

class AuthenticationService {
  static AuthenticationService get instance => AuthenticationService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      final data = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Prefs.instance.setToken(token: data.user!.uid);

      final response = await AuthRepository.instance.postUserAuthData(
        userData: dio.FormData.fromMap(
          {
            "last_login_ip": await getIp(),
            "user_id": data.user!.uid,
            "provider": data.user!.providerData[0].providerId
          },
        ),
      );

      return response; // Successful sign-up, no error
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code);
    } catch (e) {
      throw e.toString(); // Return an error message
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final data = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Prefs.instance.setToken(token: data.user!.uid);

      final response = await AuthRepository.instance.postUserAuthData(
        userData: dio.FormData.fromMap(
          {
            "last_login_ip": await getIp(),
            "user_id": data.user!.uid,
            "provider": data.user!.providerData[0].providerId
          },
        ),
      );

      return response; // Successful sign-up, no error
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code);
    } catch (e) {
      throw e.toString(); // Return an error message
    }
  }

  Future<void> phoneAuthentication(
      {required String phoneNumber,
      required WidgetRef ref,
      required BuildContext context}) async {
    try {
      await auth.verifyPhoneNumber(
        forceResendingToken: ref.read(resendTokenProvider) == 0
            ? null
            : ref.read(resendTokenProvider),
        phoneNumber: "+91$phoneNumber",
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          final exception = AppFirebaseAuthException(e.code);
          DialogComponents.snackBar(context, exception.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          ref
              .read(verificationIdProvider.notifier)
              .update((state) => verificationId);

          ref
              .read(resendTokenProvider.notifier)
              .update((state) => resendToken!);
          DialogComponents.loaderStop(context);
          Navigator.of(context).pushNamed(Verification.routeName);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          null;
        },
      );
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code);
    } catch (e) {
      throw e.toString(); // Return an error message
    }
  }

  Future verifyOTP(
      {required String verificationId,
      required String otp,
      required BuildContext context}) async {
    try {
      final data = await auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      ));
      Prefs.instance.setToken(token: data.user!.uid);

      final response = await AuthRepository.instance.postUserAuthData(
        userData: dio.FormData.fromMap(
          {
            "last_login_ip": await getIp(),
            "user_id": data.user!.uid,
            "provider": data.user!.providerData[0].providerId
          },
        ),
      );

      return response; // Successful sign-up, no error
    } on FirebaseAuthException catch (e) {
      final exception = AppFirebaseAuthException(e.code);
      DialogComponents.loaderStop(context);
      DialogComponents.snackBar(context, exception.message);
      throw exception;
    } catch (e) {
      throw e.toString(); // Return an error message
    }
  }

  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        final data =
            await FirebaseAuth.instance.signInWithCredential(credential);

        Prefs.instance.setToken(token: data.user!.uid);

        final response = await AuthRepository.instance.postUserAuthData(
          userData: dio.FormData.fromMap(
            {
              "last_login_ip": await getIp(),
              "user_id": data.user!.uid,
              "provider": credential.signInMethod
            },
          ),
        );

        return response;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code);
    } catch (e) {
      throw e.toString();
    }
  }

  // Sign out
  Future signOut(BuildContext context) async {
    Prefs.remove("token");
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
  }

  // Get the current user
  User? getCurrentUser() {
    return auth.currentUser;
  }
}

//Sign In With Mobile Number/OTP
  // Future<void> signInWithPhoneNumber(
  //     String countryCode, String phoneNumber, BuildContext context) async {
  //   // Check userExistance
  //   QuerySnapshot<Object?> userSnapshot =
  //       await DB.users().where('mobile', isEqualTo: phoneNumber).get();
  //   if (userSnapshot.docs.isNotEmpty) {
  //     await FirebaseAuth.instance
  //         .verifyPhoneNumber(
  //           phoneNumber: countryCode + phoneNumber,
  //           verificationCompleted: (PhoneAuthCredential credential) {},
  //           verificationFailed: (FirebaseAuthException e) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text(e.message.toString()),
  //               ),
  //             );
  //           },
  //           codeSent: (String verificationId, int? resendToken) {
  //             isOtpSent = true;
  //             otpVerificationId = verificationId;
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text(language.otpCodeIsSentToYourMobileNumber),
  //               ),
  //             );
  //             notifyListeners();
  //           },
  //           codeAutoRetrievalTimeout: (String verificationId) {},
  //         )
  //         .onError((FirebaseAuthException error, stackTrace) => snackBar(
  //             navigatorKey.currentContext!,
  //             title: error.message.toString()));
  //   } else {
  //     Future.delayed(Duration.zero, () {
  //       snackBar(context,
  //           title: language.notRegisteredYet,
  //           snackBarAction: SnackBarAction(
  //               label: language.signUp,
  //               onPressed: () {
  //                 const SignupScreen().launch(context);
  //               }));
  //     });
  //   }
  // }
// OTP Verification
  // Future<void> verifyOtp(
  //     {required String verificationId,
  //     required String smsCode,
  //     required BuildContext context}) async {
  //   try {
  //     AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId,
  //       smsCode: smsCode,
  //     );
  //     await auth.signInWithCredential(credential);
  //     // Update User Data
  //     QuerySnapshot<Object?> userSnapshot = await DB
  //         .users()
  //         .where('mobile', isEqualTo: mobileNumberController.text)
  //         .get();
  //     Map<String, dynamic> userData =
  //         userSnapshot.docs.first.data() as Map<String, dynamic>;
  //     saveUserDataToSharedPref(userData);
  //     Future.delayed(Duration.zero, () {
  //       context.read<AppSettings>().setLoggedIn(true);
  //     });
  //     Future.delayed(Duration.zero, () {
  //       const SplashScreen().launch(context);
  //     });
  //   } catch (e) {
  //     if (e is FirebaseAuthException) {
  //       // Handle FirebaseAuthException with a specific message
  //       String errorMessage = e.message ?? "An unknown error occurred";
  //       snackBar(navigatorKey.currentContext!, title: errorMessage.toString());
  //     } else {
  //       // Handle other types of exceptions
  //       snackBar(navigatorKey.currentContext!,
  //           title: "An unknown error occurred");
  //     }
  //   }
  // }
