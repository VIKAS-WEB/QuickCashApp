import 'package:flutter/material.dart';
import 'package:quickcash/Screens/ForgotScreen/model/forgotPasswordApi.dart';
import 'package:quickcash/Screens/LoginScreen/login_screen.dart';
import '../../../constants.dart';
import '../../../util/customSnackBar.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordForm> {
  final _fromKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(); // Add the controller
  String? email;

  final ForgotPasswordApi _forgotPasswordPasswordApi = ForgotPasswordApi();

  bool isLoading = false;
  String? errorMessage;

  Future<void> mForgotPassword() async {
    if (_fromKey.currentState!.validate()) {
      _fromKey.currentState!.save();

      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      try {
        final response = await _forgotPasswordPasswordApi.forgotPassword(email!);

        setState(() {
          isLoading = false;
        });

        if (response.message == "Success") {
          _emailController.clear(); // Clear the text field on success
          CustomSnackBar.showSnackBar(
            context: context,
            message: 'Check your Registered mail, we have sent a reset password link',
            color: kGreeneColor, // Set the color of the SnackBar
          );
        } else {
          CustomSnackBar.showSnackBar(
            context: context,
            message: 'We are facing some issue!',
            color: kRedColor, // Set the color of the SnackBar
          );
        }

      } catch (error) {
        setState(() {
          isLoading = false;
          errorMessage = error.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _fromKey,
        child: Column(
          children: [
            const Center(
              child: Text(
                'Please enter your email address. You will receive a link to create a new password via email.',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 35),
            TextFormField(
              controller: _emailController, // Use the controller here
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (value) {
                email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // Regex for basic email validation
                final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Your Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),

            if (isLoading) const CircularProgressIndicator(color: kPrimaryColor,), // Show loading indicator
            if (errorMessage != null) // Show error message if there's an error
              Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: defaultPadding,),

            ElevatedButton(
              onPressed: isLoading ? null : mForgotPassword,
              child: const Text(
                "Reset Password",
              ),
            ),
            const SizedBox(height: defaultPadding),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Remember Your Password?',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
