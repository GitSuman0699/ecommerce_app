import 'package:firebase_project/utils/common_widgets/gradient_header.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const String routeName = 'settings';
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildTile(Icons.devices_other, 'Theme', () {}),
        _buildTile(Icons.language_outlined, 'Language', () {}),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const AppHeaderGradient(
      isProfile: false,
      text: 'Settings',
    );
  }

  Widget _buildTile(IconData icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.white,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.primary,
          ),
          title: Text(title),
        ),
      ),
    );
  }
}
