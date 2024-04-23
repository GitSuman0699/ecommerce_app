import 'package:firebase_project/login/phone_screen.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/app_tittle.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/device/device_utility.dart';
import 'package:firebase_project/utils/local_storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoarding extends StatelessWidget {
  static const String routeName = 'onboarding';
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: AppDeviceUtils.getScreenHeight(context),
          child: Stack(
            children: [
              Image(
                image: const AssetImage('assets/images/onboarding.gif'),
                color: const Color.fromRGBO(42, 3, 75, 0.35),
                colorBlendMode: BlendMode.srcOver,
                fit: BoxFit.fill,
                height: AppDeviceUtils.getScreenHeight(context) * 0.75,
                width: AppDeviceUtils.getScreenWidth(context),
              ),
              Positioned(
                bottom: AppDeviceUtils.getScreenHeight(context) * 0.24,
                right: 0,
                child: Container(
                  width: AppDeviceUtils.getScreenWidth(context) * 0.65,
                  height: AppDeviceUtils.getScreenHeight(context) * 0.13,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  height: AppDeviceUtils.getScreenHeight(context) * 0.30,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    backgroundBlendMode: BlendMode.srcOver,
                    gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.primary],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0, 1]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getAppTitle(),
                      getAppDesc(),
                      AppButton.button(
                        text: 'Get Started',
                        color: AppColors.white,
                        width: 240.0.w,
                        height: 40.0.h,
                        textColor: AppColors.black,
                        onTap: () {
                          Prefs.setBool("visited_onboarding", true);
                          debugPrint(
                              Prefs.getBool("visited_onboarding").toString());
                          Navigator.pushNamed(context, Login.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppTitle() {
    return AppTitle(
      fontStyle: FontStyles.montserratExtraBold31(),
      marginTop: 25.0,
    );
  }

  Widget getAppDesc() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Text(
        'Empowering Your Shopping Experience,\n One Click at a Time.',
        style:
            FontStyles.montserratRegular14().copyWith(color: AppColors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
