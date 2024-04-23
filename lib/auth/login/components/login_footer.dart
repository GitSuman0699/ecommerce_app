import 'package:firebase_project/Main/main.dart';
import 'package:firebase_project/auth/authentication_service.dart';
import 'package:firebase_project/utils/device/device_utility.dart';
import 'package:firebase_project/utils/local_storage/storage.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDeviceUtils.getScreenWidth(context),
      child: ElevatedButton.icon(
        onPressed: () async {
          final response =
              await AuthenticationService.instance.signInWithGoogle();
          if (response != null) if (response["status_code"] == 200) {
            // Prefs.instance.setToken(token: response['token']['token']);
            Navigator.of(context).popAndPushNamed(Main.routeName);
          }
        },
        icon: const Icon(Icons.g_mobiledata_rounded),
        label: const Text("Sign-In with Google"),
      ),
    );
  }
}
