import 'package:firebase_project/auth/authentication_service.dart';
import 'package:firebase_project/auth/login/login_screen.dart';
import 'package:firebase_project/login/verification_screen.dart';
import 'package:firebase_project/login/widgets/phone_input.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/gradient_header.dart';
import 'package:firebase_project/utils/common_widgets/dialog_components.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/device/device_utility.dart';
import 'package:firebase_project/utils/device/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends ConsumerStatefulWidget {
  static const String routeName = 'login';
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context, formKey),
    );
  }

  Widget _buildBody(BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildWidget(context, formKey),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const AppHeaderGradient(
      text: 'What Is Your Phone Number',
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
            'Please enter your phone number to verify your account',
            style: FontStyles.montserratRegular17(),
          ),
          UIHelper.verticalSpaceLarge(),
          _buildPhoneField(context, formKey),
          UIHelper.verticalSpaceLarge(),
          _buildSendButton(context, formKey),
          UIHelper.verticalSpaceMedium(),
          _buildSkipButton()
        ],
      ),
    );
  }

  Widget _buildPhoneField(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return PhoneInput(formKey: formKey);
  }

  Widget _buildSendButton(
      BuildContext context, GlobalKey<FormBuilderState> formKey) {
    return AppButton.button(
        width: double.infinity,
        color: AppColors.primary,
        onTap: () {
          if (formKey.currentState!.saveAndValidate()) {
            DialogComponents.loaderShow(context);
            debugPrint(formKey.currentState?.value["mobile"].toString().trim());
            AuthenticationService.instance.phoneAuthentication(
                phoneNumber:
                    formKey.currentState!.value["mobile"].toString().trim(),
                ref: ref,
                context: context);
          }
        },
        text: 'Send Code',
        textColor: AppColors.white);
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen(),
          ),
        );
      },
      child: Text(
        'Login with email instead',
        style: FontStyles.montserratBold14().copyWith(color: AppColors.primary),
      ),
    );
  }
}
