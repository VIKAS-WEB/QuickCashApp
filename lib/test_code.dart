import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';

import 'Screens/HomeScreen/home_screen.dart';
import 'Screens/WelcomeScreen/components/login_signup_btn.dart';
import 'Screens/WelcomeScreen/components/welcome_image.dart';
import 'Screens/util/auth_manager.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AuthManager.getUserId().isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
        );
      }
    });


    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: WelcomeImage(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: LoginAndSignupBtn(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WelcomeImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 14,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
