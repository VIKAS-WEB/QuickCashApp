import 'package:flutter/material.dart';

import '../../../constants.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isPasswordMatch = false;  // Track if password and confirm password match

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
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: defaultPadding),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: !_isPasswordVisible,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!_isPasswordValid(value)) {
                          return 'Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character.';
                        }
                        return null;
                      },
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),

                    // Confirm Password
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      controller: _confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      obscureText: !_isConfirmPasswordVisible,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your confirm password';
                        }
                        if (!_isPasswordValid(value)) {
                          return 'Confirm password must contain at least one lowercase letter, one uppercase letter, one number, and one special character.';
                        }
                        return null;
                      },
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),

                    // OTP - Only show if password and confirm password match
                    if (_isPasswordMatch) ...[
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        cursorColor: kPrimaryColor,
                        onSaved: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter OTP';
                          }
                          return null;
                        },
                        style: const TextStyle(color: kPrimaryColor),
                        decoration: InputDecoration(
                          labelText: "OTP",
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ],

                    // Submit Button
                    const SizedBox(height: 35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
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
                            // Check if passwords match
                            if (_passwordController.text != _confirmPasswordController.text) {
                              // If passwords do not match, show a SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Passwords do not match!')),
                              );
                              setState(() {
                                _isPasswordMatch = false;  // Hide OTP field if passwords do not match
                              });
                              return;
                            } else {
                              setState(() {
                                _isPasswordMatch = true;  // Show OTP field if passwords match
                              });

                              _formKey.currentState!.save();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Otp has been Sent On Registered EmailId')),
                              );
                            }
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
