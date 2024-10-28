import 'package:flutter/material.dart';

import '../../constants.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordValid(String password) {
    // Regex to check password criteria
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: defaultPadding),

                    // Password
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      cursorColor: kPrimaryColor,
                      onSaved: (value){},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!_isPasswordValid(value)) {
                          return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character.';
                        }
                        return null;
                      },

                      readOnly: false,
                      style: const TextStyle(color: kPrimaryColor),

                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),


                    // Confirm Password
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      cursorColor: kPrimaryColor,
                      onSaved: (value){},

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your confirm password';
                        }
                        if (!_isPasswordValid(value)) {
                          return 'Confirm password must contain at least one lowercase letter, one uppercase letter, one number, and one special character.';
                        }

                        return null;
                      },

                      readOnly: false,
                      style: const TextStyle(color: kPrimaryColor),

                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),

                    // Submit Button
                    const SizedBox(height: 35),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, save the form data
                            _formKey.currentState!.save();
                            // Handle further logic, like navigating or saving data
                            // For example, show a success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },

                        child: const Text('Submit', style: TextStyle(color: Colors.white)),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}