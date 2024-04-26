import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Map<String, dynamic> getDecodedJwtToken({required String token}) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  return decodedToken;
}

Future<String> getIp() async {
  String strIp = '';
  List interfaces = await NetworkInterface.list();

  strIp = interfaces.isEmpty ? "" : interfaces[0].addresses[0].address;

  return strIp.toString().trim();
}

String indianRupee(String text) {
  return "₹$text";
}

void showCupertinoSnackBar({
  required BuildContext context,
  required String message,
  int durationMillis = 3000,
}) {
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 30,
      // bottom: 8.0,
      // left: 8.0,
      // right: 8.0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CupertinoPopupSurface(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.0,
                color: CupertinoColors.secondaryLabel,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  );
  Future.delayed(
    Duration(milliseconds: durationMillis),
    overlayEntry.remove,
  );
  Overlay.of(Navigator.of(context).context).insert(overlayEntry);
}
