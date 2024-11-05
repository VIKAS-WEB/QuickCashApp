import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static late SharedPreferences _sharedPref;

  static Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _sharedPref.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static Future<void> saveUserId(String id) async {
    await _sharedPref.setString('user_id', id);
  }

  static String getUserId() {
    return _sharedPref.getString('user_id') ?? '';
  }

  static String getToken(){
    return _sharedPref.getString('access_token') ?? '';
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logout() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }

  static bool isLoggedIn() {
    String token = readAuth();
    return token.isNotEmpty;
  }

}
