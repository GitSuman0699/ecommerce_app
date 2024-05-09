import 'package:firebase_project/screens/root/root_screen.dart';
import 'package:firebase_project/screens/auth/authentication_service.dart';
import 'package:firebase_project/screens/auth/login/login_controller.dart';
import 'package:firebase_project/screens/login/phone_screen.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/dialog_components.dart';
import 'package:firebase_project/utils/common_widgets/gradient_header.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/device/device_utility.dart';
import 'package:firebase_project/utils/device/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Verification extends ConsumerStatefulWidget {
  const Verification({super.key});
  static const String routeName = 'verification';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerificationState();
}

class _VerificationState extends ConsumerState<Verification> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildWidget(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const AppHeaderGradient(
      text: 'Verification Code',
      isProfile: false,
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please enter code send to',
            style: FontStyles.montserratRegular17(),
          ),
          UIHelper.verticalSpaceMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '+919898989898',
                style: FontStyles.montserratBold17(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Login.routeName);
                },
                child: Text(
                  'Change phone number',
                  style: FontStyles.montserratRegular12()
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          UIHelper.verticalSpaceLarge(),
          _buildOTPField(context),
          UIHelper.verticalSpaceLarge(),
          _buildContinueButton(context),
          UIHelper.verticalSpaceMedium(),
          _buildResendCodeButton(context),
        ],
      ),
    );
  }

  Widget _buildOTPField(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: FormBuilderTextField(
        style: FontStyles.montserratRegular14(),
        name: 'otp',
        decoration: InputDecoration(
          labelText: '6-digit OTP',
          labelStyle: FontStyles.montserratRegular14(),
          prefixStyle: FontStyles.montserratRegular14(),
          prefixIcon: const Icon(
            Icons.phone_android_outlined,
            color: AppColors.primary,
          ),
        ),
        onChanged: (code) {
          if (code!.length == 6) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: 'OTP is requied'),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.maxLength(6,
              errorText: 'OTP should be of 6 digit'),
          FormBuilderValidators.minLength(6,
              errorText: 'OTP should be of 6 digit'),
        ]),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Center(
      child: AppButton.button(
        width: AppDeviceUtils.getScreenWidth(context),
        color: AppColors.primary,
        text: 'Continue',
        textColor: AppColors.white,
        onTap: () async {
          if (formKey.currentState!.saveAndValidate()) {
            DialogComponents.loaderShow(context);

            final response = await AuthenticationService.instance.verifyOTP(
                verificationId: ref.read(verificationIdProvider),
                otp: formKey.currentState!.value['otp'],
                context: context);

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
      ),
    );
  }

  Widget _buildResendCodeButton(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {},
          child: Text(
            'Resend Code',
            style: FontStyles.montserratBold17().copyWith(color: Colors.grey),
          )),
    );
  }
}
