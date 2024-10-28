import 'package:flutter/material.dart';
import '../../../constants.dart';

class ForgotPasswordTopImage extends StatelessWidget {
  const ForgotPasswordTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Forgot Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: kPrimaryColor),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset("assets/images/image4.jpg"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
