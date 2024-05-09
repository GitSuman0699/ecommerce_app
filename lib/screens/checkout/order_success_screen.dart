import 'package:firebase_project/screens/root/root_screen.dart';
import 'package:firebase_project/screens/orders/order.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSucessScreen extends StatelessWidget {
  static const String routeName = 'order_success_screen';
  const OrderSucessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: AppColors.primary,
            gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primary],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0, 1]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(120.0.r),
                bottomRight: Radius.circular(120.0.r))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: const AssetImage('assets/checkOut/check.png'),
                height: 70.0.h,
              ),
            ),
            Text(
              'Success',
              style: FontStyles.montserratBold25(),
            ),
            SizedBox(height: 10.0.h),
            Text(
              'Your order will be delivered soon.',
              style: FontStyles.montserratRegular14(),
            ),
            Text(
              'It can be tracked in the "Orders" section.',
              style: FontStyles.montserratRegular14(),
            ),
            SizedBox(height: 10.0.h),
            Container(
              margin: EdgeInsets.only(bottom: 10.0.h),
              child: AppButton.button(
                text: 'Continue Shopping',
                color: AppColors.white,
                height: 48.h,
                width: 200.w,
                textColor: Colors.black,
                onTap: () {
                  Navigator.popAndPushNamed(context, Main.routeName);
                  // Navigator.pushReplacementNamed(context, Main.routeName);
                  // Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 20.0.h),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, OrderScreen.routeName);
              },
              child: Text(
                'Go to Orders',
                style:
                    FontStyles.montserratBold17().copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 10.0.h),
          ],
        ),
      ),
    );
  }
}
