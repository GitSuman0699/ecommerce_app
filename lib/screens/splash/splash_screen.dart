import 'package:firebase_project/Main/main.dart';
import 'package:firebase_project/screens/login/phone_screen.dart';
import 'package:firebase_project/utils/local_storage/storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Prefs.instance.getToken().isEmpty ? Login() : Main();

    // StreamBuilder(
    //   stream: AuthenticationService.instance.auth.authStateChanges(),

    //   // FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       // check is user logged in or not
    //       if (snapshot.hasData) {
    //         return const Main();
    //         // check if there's any error or not
    //       } else if (snapshot.hasError) {
    //         ErrorDescription("Unknown Error From Main Firebase");
    //       }
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     // new user or logged out user will be redirected to login screen
    //     return const Login();
    //     // return const OtpScreen();
    //   },
    // );
  }
}
