import 'package:firebase_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({this.marginTop, super.key, this.fontStyle});
  final double? marginTop;
  final TextStyle? fontStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop!),
      child: RichText(
        text: TextSpan(
          text: 'Click',
          style: fontStyle!.copyWith(color: AppColors.accent),
          children: [
            TextSpan(
              text: 'Mart',
              style: fontStyle!.copyWith(color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
