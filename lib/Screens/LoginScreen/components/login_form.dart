// login_form.dart
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/ForgotScreen/forgot_pawwsord_screen.dart';
import 'package:quickcash/components/check_already_have_an_account.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/Screens/SignupScreen/signup_screen.dart';

import '../../../util/auth_manager.dart';
import '../../HomeScreen/home_screen.dart';
import '../models/loginApi.dart';



class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(text: 'saurabhk@itio.in');
  final TextEditingController password = TextEditingController(text: 'Saurabh@12345\$\$');
  final LoginApi _loginApi = LoginApi();

  bool isLoading = false;
  String? errorMessage;

  bool _isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      try {
        final response = await _loginApi.login(email.text, password.text);
        setState(() {
          isLoading = false;
        });

        // Save user ID and token to SharedPreferences
        await AuthManager.saveUserId(response.userId);
        await AuthManager.saveToken(response.token);
        await AuthManager.saveUserName(response.name);
        await AuthManager.saveUserEmail(response.email);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()), // replace HomeScreen with your actual home screen
        );

      } catch (error) {
        setState(() {
          isLoading = false;
          errorMessage = error.toString();
        });
      }
    }
  }


  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (!_isPasswordValid(value)) {
                  return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character.';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Your Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          if (isLoading) const CircularProgressIndicator(color: kPrimaryColor,), // Show loading indicator
          if (errorMessage != null) // Show error message if there's an error
            const Text('Invalid Credentials!', style: TextStyle(color: Colors.red)),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: isLoading ? null : _login, // Disable button if loading
            child: const Text("Sign In"),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}