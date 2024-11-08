import 'package:flutter/material.dart';
import 'package:quickcash/Screens/UserProfileScreen/SecurityScreen/ChangePasswordModel/changePasswordApi.dart';
import 'package:quickcash/util/auth_manager.dart';
import 'package:quickcash/util/customSnackBar.dart';

import '../../../constants.dart';
import 'SendOTPModel/sendOTPApi.dart';

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
  bool _isPasswordMatch = false;
  bool isOtpSent = false;

  final SendOTPApi _securityApi = SendOTPApi();
  final ChangePasswordApi _changePasswordApi = ChangePasswordApi();

  bool _isPasswordValid(String password) {
    // Regex to check password criteria
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  bool isLoading = false;
  String? errorMessage;

  Future<void> mSendOtpApi() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords does not match!')),
        );
        setState(() {
          _isPasswordMatch = false;
        });
        return;
      } else {
        setState(() {
          _isPasswordMatch = true;
          isLoading = true;
          errorMessage = null;
        });

        try {
          final response = await _securityApi.sendOTP(AuthManager.getUserEmail(), AuthManager.getUserName());
          setState(() {
            isLoading = false;
            isOtpSent = true;
          });

          AuthManager.saveOTP(response.otp.toString());
          CustomSnackBar.showSnackBar(
            context: context,
            message: response.message!,
            color: kPrimaryColor,
          );
        } catch (error) {
          setState(() {
            isLoading = false;
            errorMessage = error.toString();
          });
        }
      }
    }
  }

  Future<void> mChangePasswordApi() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _changePasswordApi.changePassword(_passwordController.text, _confirmPasswordController.text);

      setState(() {
        isLoading = false;
        errorMessage = null;
        isOtpSent = false;
      });

      CustomSnackBar.showSnackBar(
        context: context,
        message: response.message!,
        color: kPrimaryColor,
      );
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  void handleSubmit() {
    if (!isOtpSent) {
      // If OTP has not been sent, send OTP
      mSendOtpApi();
    } else {
      // If OTP has already been sent, verify OTP and change password
      final savedOtp = AuthManager.getOtp();
      final enteredOtp = _otpController.text;

      if (enteredOtp == savedOtp) {
        mChangePasswordApi();
      } else {
        CustomSnackBar.showSnackBar(
          context: context,
          message: 'Invalid OTP. Please try again.',
          color: Colors.red,
        );
      }
    }
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
                    if (isLoading) const CircularProgressIndicator(color: kPrimaryColor),
                    if (errorMessage != null)
                      Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: defaultPadding),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: !_isPasswordVisible,
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
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
                      obscureText: !_isConfirmPasswordVisible,
                      cursorColor: kPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your confirm password';
                        }
                        if (!_isPasswordValid(value)) {
                          return 'Confirm password must contain at least one lowercase letter, one uppercase letter, one number, and one special character.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
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

                    // OTP
                    if (_isPasswordMatch) ...[
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        cursorColor: kPrimaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter OTP';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "OTP",
                        ),
                      ),
                    ],

                    // Submit Button
                    const SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: isLoading ? null : handleSubmit,
                      child: const Text('Submit'),
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
