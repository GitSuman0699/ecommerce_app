import 'package:firebase_project/Main/main.dart';
import 'package:firebase_project/auth/authentication_service.dart';
import 'package:firebase_project/auth/signup/signup_screen.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/dialog_components.dart';
import 'package:firebase_project/utils/common_widgets/gradient_header.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/device/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/login_footer.dart';
import 'components/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSignInBody(context, formKey),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInBody(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return Column(
      children: [
        _buildSignInHeader(),
        _buildSignInWidget(context, formKey),
      ],
    );
  }

  Widget _buildSignInHeader() {
    return const AppHeaderGradient(
      text: 'Login with email and password',
      isProfile: false,
    );
  }

  Widget _buildSignInWidget(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      child: Column(
        children: [
          Text(
            'Please enter your email and password to verify your account',
            style: FontStyles.montserratRegular17(),
          ),
          UIHelper.verticalSpaceLarge(),
          _buildSignInFormWidget(context, formKey),
          _buildForgotPassword(),
          _buildSignInLoginButton(context, formKey),
          UIHelper.verticalSpaceSmall(),
          _buildOrWidget(),
          UIHelper.verticalSpaceSmall(),
          _buildLoginFooter(),
          UIHelper.verticalSpaceLarge(),
          _buildSignUp(),
        ],
      ),
    );
  }

  Widget _buildSignInFormWidget(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return LoginFormWidget(formKey: formKey);
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Forgot Password?",
          style: FontStyles.montserratBold12(),
        ),
      ),
    );
  }

  Widget _buildSignInLoginButton(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return AppButton.button(
        width: double.infinity,
        color: AppColors.primary,
        onTap: () async {
          DialogComponents.loaderShow(context);
          if (formKey.currentState!.saveAndValidate()) {
            final response =
                await AuthenticationService.instance.signInWithEmailAndPassword(
              formKey.currentState!.value["email"].toString().trim(),
              formKey.currentState!.value["password"].toString().trim(),
            );

            if (response != null) if (response["status_code"] == 200) {
              DialogComponents.loaderStop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                Main.routeName,
                (route) => false,
              );
            } else {
              DialogComponents.loaderStop(context);
            }
          }
        },
        text: 'Login',
        textColor: AppColors.white);
  }

  Widget _buildOrWidget() {
    return Text(
      'OR',
      style: FontStyles.montserratBold14().copyWith(color: AppColors.primary),
    );
  }

  Widget _buildLoginFooter() {
    return const LoginFooter();
  }

  Widget _buildSignUp() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen(),
          ),
        );
      },
      child: Text(
        "Don't have account? SignUp",
        style: FontStyles.montserratBold14().copyWith(color: AppColors.primary),
      ),
    );
  }
}
