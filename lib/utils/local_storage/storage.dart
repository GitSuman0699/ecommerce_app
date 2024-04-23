import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._privateConstructor();
  static late SharedPreferences _preference;

  static final Prefs _instance = Prefs._privateConstructor();

  static Prefs get instance => _instance;

  init() async {
    _preference = await SharedPreferences.getInstance();
  }

  //set token
  void setToken({required String token}) {
    _preference.setString('token', token);
    debugPrint('token: $token');
  }

  //get token
  String getToken() {
    return _preference.getString('token') ?? '';
  }

  //get theme
  bool getTheme() {
    return _preference.getBool('dark') ?? false;
  }

  //set theme
  void setTheme({required bool theme}) {
    _preference.setBool('dark', theme);
  }

  //sets
  static Future<bool> setBool(String key, bool value) async =>
      await _preference.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _preference.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _preference.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _preference.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _preference.setStringList(key, value);

  //gets
  static bool getBool(String key) => _preference.getBool(key) ?? false;

  static double getDouble(String key) => _preference.getDouble(key) ?? 0.0;

  static int getInt(String key) => _preference.getInt(key) ?? 0;

  static String getString(String key) => _preference.getString(key) ?? '';

  dynamic get(String key) => _preference.get(key) ?? '';

  static List<String> getStringList(String key) =>
      _preference.getStringList(key) ?? [];

  //deletes..
  static Future<bool> remove(String key) async => await _preference.remove(key);

  static Future<bool> clear() async => await _preference.clear();

  String getUserPermission() {
    return _preference.getString('userPermission') ?? '';
  }

  String getUserPermissionFetchDate() {
    return _preference.getString('userPermissionFetchDate') ?? '';
  }

  void setUserPermissionFetchDate(DateTime date) {
    _preference.setString('userPermissionFetchDate', date.toString());
  }

  Future<void> setFirebaseToken({required String token}) async {
    await _preference.setString('firebaseToken', token);
  }
}
