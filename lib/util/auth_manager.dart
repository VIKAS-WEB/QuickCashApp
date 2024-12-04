import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static late SharedPreferences _sharedPref;

  static Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  // Save UserId
  static Future<void> saveUserId(String id) async {
    await _sharedPref.setString('user_id', id);
  }

  static String getUserId() {
    return _sharedPref.getString('user_id') ?? '';
  }

  // Save Kyc Status
  static Future<void> saveKycStatus(String id) async {
    await _sharedPref.setString('kyc_status', id);
  }

  static String getKycStatus() {
    return _sharedPref.getString('kyc_status') ?? '';
  }


  // Save UserName
  static Future<void> saveUserName(String name) async {
    await _sharedPref.setString('user_name', name);
  }

  static String getUserName() {
    return _sharedPref.getString('user_name') ?? '';
  }

  // Save UserEmail
  static Future<void> saveUserEmail(String email) async {
    await _sharedPref.setString('user_email', email);
  }

  static String getUserEmail() {
    return _sharedPref.getString('user_email') ?? '';
  }

  // Save UserImage
  static Future<void> saveUserImage(String image) async {
    await _sharedPref.setString('user_image', image);
  }

  static String getUserImage() {
    return _sharedPref.getString('user_image') ?? '';
  }

  // Save OTP
  static Future<void> saveOTP(String otp) async {
    await _sharedPref.setString('otp', otp);
  }

  static String getOtp() {
    return _sharedPref.getString('otp') ?? '';
  }

  // Access Token
  static Future<void> saveToken(String token) async {
    await _sharedPref.setString('access_token', token);
    authChangeNotifier.value = token;
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
