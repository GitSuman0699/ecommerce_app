import 'package:firebase_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({this.hintText, this.labelText, this.onTap, super.key});
  final String? hintText, labelText;
  final Function()? onTap;
  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        fillColor: AppColors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: widget.hintText,
        labelText: widget.labelText,
      ),
      onTap: widget.onTap,
    );
  }
}
