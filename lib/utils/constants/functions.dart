import 'dart:io';

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
