import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:quickcash/Screens/ForgotScreen/forgot_pasword_screen.dart';
import 'package:quickcash/Screens/SignupScreen/components/OtpField.dart';
import 'package:quickcash/Screens/UserProfileScreen/SecurityScreen/ResusableWidget/Success.dart';
import 'package:quickcash/Screens/UserProfileScreen/SecurityScreen/security_screen.dart';
import 'package:quickcash/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/auth_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51P1Nc4SFNdFpGeTocG7DYUCP1whAkNkCHJmvBH11xvppDmpJPWBdmm5MY4AwWQaYh9KHrijNJEN9oBmSPXI5ZFcM00QSo7IgQE';
  await AuthManager.init();
  runApp(const QuickCashApp());
}

class QuickCashApp extends StatelessWidget {
  const QuickCashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quickcash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none))),
      home: const WelcomeScreen(),
    );
  }
}
