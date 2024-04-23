import 'package:firebase_project/Main/main.dart';
import 'package:firebase_project/auth/authentication_service.dart';
import 'package:firebase_project/auth/login/components/login_footer.dart';
import 'package:firebase_project/auth/signup/components/signup_form_widget.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/dialog_components.dart';
import 'package:firebase_project/utils/common_widgets/gradient_header.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/device/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey2 = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [_buildBody(context, formKey2)],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return Column(
      children: [
        _buildHeader(),
        _buildWidget(context, formKey),
      ],
    );
  }

  Widget _buildHeader() {
    return const AppHeaderGradient(
      text: 'SignUp with email and password',
      isProfile: false,
    );
  }

  Widget _buildWidget(
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
          _buildFormWidget(context, formKey),
          UIHelper.verticalSpaceLarge(),
          // _buildForgotPassword(),
          _buildSignUpButton(context, formKey),
          UIHelper.verticalSpaceSmall(),
          _buildOrWidget(),
          UIHelper.verticalSpaceSmall(),
          _buildLoginFooter()
        ],
      ),
    );
  }

  Widget _buildFormWidget(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return SignupFormWidget(formKey: formKey);
  }

  Widget _buildSignUpButton(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return AppButton.button(
        width: double.infinity,
        color: AppColors.primary,
        onTap: () async {
          DialogComponents.loaderShow(context);
          if (formKey.currentState!.saveAndValidate()) {
            if (formKey.currentState!.value["password"].toString().trim() ==
                formKey.currentState!.value["confirmpassword"]
                    .toString()
                    .trim()) {
              final response = await AuthenticationService.instance
                  .signUpWithEmailAndPassword(
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
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Password and confirm password didn't match")));
            }
          }
        },
        text: 'SignUp',
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
}
