import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';

class AppButton {
  static Widget button(
      {double? height,
      double? width,
      Color? color,
      String? text,
      Color? textColor,
      Function()? onTap}) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onTap,
        child: Text(
          text!,
          style: FontStyles.montserratBold17().copyWith(color: textColor),
        ),
      ),
    );

    // Container(
    //   height: height,
    //   width: width,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10.0), color: color),
    //   child: TextButton(
    //     onPressed: onTap!,
    //     child:
    //   ),
    // );
  }
}
