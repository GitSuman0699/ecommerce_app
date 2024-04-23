import 'package:firebase_project/screens/Orders/order.dart';
import 'package:firebase_project/screens/PrivacyPolicy/privacy_policy.dart';
import 'package:firebase_project/screens/Settings/settings.dart';
import 'package:firebase_project/screens/ShippingAddress/shipping_address.dart';
import 'package:firebase_project/screens/SignUp/sign_up.dart';
import 'package:firebase_project/screens/on_boarding/on_boarding_screen.dart';
import 'package:firebase_project/utils/common_widgets/gradient_header.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  static const String routeName = 'profile';
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppHeaderGradient(
                isProfile: true,
                fixedHeight: screenHeight * .24.h,
                text: 'Oleh Chabanov',
              ),
              Positioned(
                top: screenHeight * .14.h,
                right: 20.0.w,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.0.r),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUp.routeName);
                    },
                    child: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0.h),
          _buildProfileTile(Icons.location_on_outlined, 'Shipping Address', () {
            Navigator.pushNamed(context, ShippingAddress.routeName);
          }),
          _buildProfileTile(Icons.payment_rounded, 'Payment Method', () {}),
          _buildProfileTile(Icons.border_all, 'Orders', () {
            Navigator.pushNamed(context, OrderScreen.routeName);
          }),
          _buildProfileTile(Icons.settings, 'Settings', () {
            Navigator.pushNamed(context, Settings.routeName);
          }),
          _buildProfileTile(Icons.login_outlined, 'Logout', () {
            Navigator.pushReplacementNamed(context, OnBoarding.routeName);
          }),
          _buildPrivacy(context),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.r),
          color: AppColors.white,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.primary,
          ),
          title: Text(
            title,
            style: FontStyles.montserratSemiBold17(),
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacy(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PrivacyPolicy.routeName);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20.0.w, top: 10.0.h, bottom: 100.0.h),
        child: Text(
          'Privacy Policy',
          style: FontStyles.montserratRegular12().copyWith(
            decoration: TextDecoration.underline,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
