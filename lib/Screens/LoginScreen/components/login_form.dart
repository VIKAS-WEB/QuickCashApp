// login_form.dart
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/ForgotScreen/forgot_pasword_screen.dart';
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
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final LoginApi _loginApi = LoginApi();
  bool _obsecureText = true;

  bool isLoading = false;
  String? errorMessage;

  bool _isPasswordValid(String password) {
  final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&*,.?])(?=.*[0-9]).{8,}$');
  return regex.hasMatch(password);
}

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      //Debug Print Email And Password
      print("Email: ${email.text}");
      print("Password: ${password.text}");

      try {
        final response = await _loginApi.login(email.text, password.text);

        // Debug: Print the API response
        print("Login Response: ${response.toString()}");
        print('User ID: ${response.userId}');
        print('Token: ${response.token}');
        print('Name: ${response.name}');
        print('Email: ${response.email}');
        print('Owner Profile: ${response.ownerProfile}');
        print('KycStatus :${response.kycStatus}');

        setState(() {
          isLoading = false;
        });
        
        print(response.kycStatus);
        // Save user ID and token to SharedPreferences
        await AuthManager.saveUserId(response.userId);
        await AuthManager.saveToken(response.token);
        await AuthManager.saveUserName(response.name);
        await AuthManager.saveUserEmail(response.email);
        AuthManager.saveUserImage(response.ownerProfile?.toString() ?? '');
        if (response.kycStatus == false) {
          AuthManager.saveKycStatus("completed");
        }

        Navigator.pushReplacement(
                  context,
          MaterialPageRoute(
              builder: (context) =>
                  const HomeScreen()), // replace HomeScreen with your actual home screen
        );
      } catch (error) {
        print("Login Error: $error");
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
              final regex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
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
              obscureText: _obsecureText,
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
              decoration: InputDecoration(
                hintText: "Your Password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibilty,
                    icon: Icon(
                      _obsecureText ? Icons.visibility : Icons.visibility_off,
                      color: kPrimaryColor,
                    )),
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
          if (isLoading)
            const CircularProgressIndicator(
              color: kPrimaryColor,
            ), // Show loading indicator
          if (errorMessage != null) // Show error message if there's an error
            const Text('Invalid Credentials!',
                style: TextStyle(color: Colors.red)),
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

  void _togglePasswordVisibilty() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }
}
