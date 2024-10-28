import 'package:flutter/material.dart';

import '../../../components/check_already_have_an_account.dart';
import '../../../constants.dart';
import '../../LoginScreen/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();

}

class _SignUpFormState extends State<SignUpForm> {
  final _fromKey = GlobalKey<FormState>();
  String? fullName;
  String? email;
  String? password;

  bool _isPasswordValid(String password) {
    // Regex to check password criteria
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

@override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,

            onSaved: (value){
              fullName = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty){
                return 'Please enter your full name';
              }
              return null;
            },

            decoration: const InputDecoration(
              hintText: "Full Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

          Padding(padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (value) {
                email = value;
              },
              validator: (value) {
                if (value ==null || value.isEmpty){
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
          ),

          TextFormField(
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            onSaved: (value){
              password = value;
            },
            validator: (value){
              if(value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (!_isPasswordValid(value)){
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

          const SizedBox(height: defaultPadding / 2),
          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: () {
              if (_fromKey.currentState!.validate()){
                _fromKey.currentState!.save();
                // Call your Sign Up API here ...
              }
            },
            child: const Text("Sign Up"),
          ),

          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}