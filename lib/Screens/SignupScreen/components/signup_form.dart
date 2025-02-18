import 'dart:math';

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:quickcash/Screens/SignupScreen/components/OtpField.dart';
import 'package:quickcash/Screens/SignupScreen/model/signupApi.dart';
import 'package:quickcash/util/customSnackBar.dart';

import '../../../components/check_already_have_an_account.dart';
import '../../../constants.dart';
import '../../../util/auth_manager.dart';
import '../../HomeScreen/home_screen.dart';
import '../../LoginScreen/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  bool isVerified = false;
  int generateOtp = 0;
  bool _obsecureText = true;
  bool isOtpLoading = false;

  void _togglePasswordVisibilty() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? email;
  String? password;
  String? selectedCountry;

  final SignUpApi _signUpApi = SignUpApi();

  bool isLoading = false;
  String? errorMessage;

   bool _isPasswordValid(String password) {
  final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&*,.?])(?=.*[0-9]).{8,}$');
  return regex.hasMatch(password);
}

  Future<void> mSignUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form field values to variables
      if (selectedCountry != null && selectedCountry != "Select Country") {
        setState(() {
          isLoading = true;
          errorMessage = null;
        });

        try {
          final response = await _signUpApi.signup(
              fullName!, email!, password!, selectedCountry!, "");

          setState(() {
            isLoading = false;
          });

          // Save user ID and token to SharedPreferences
          await AuthManager.saveUserId(response.userId!);
          await AuthManager.saveToken(response.token!);
          await AuthManager.saveUserName(response.name!);
          await AuthManager.saveUserEmail(response.email!);
          //Navigate to HomeScreen (uncomment this and replace with actual HomeScreen)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } catch (error) {
          setState(() {
            isLoading = false;
            errorMessage = error.toString();
          });
        }
      } else {
        setState(() {
          errorMessage = "Please select a country.";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _emailController.removeListener(_onEmailChanged);
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    final email = _emailController.text;
    if (_isValidEmail(email) && !isVerified && email.length > 6) {
      Future.delayed(const Duration(milliseconds: 500));
      _generateAndSendOtp(email);
    }
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$');
    return regex.hasMatch(email);
  }

  void _generateAndSendOtp(String email) async {
    print("OTP generation triggered for $email");
    setState(() {
      isOtpLoading = true;
      generateOtp =
          Random().nextInt(9000) + 1000; // Generate random 4-digit OTP
    });
    print("Generated OTP: $generateOtp");

    try {
      isOtpLoading = false;
      // Show progress indicator dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        },
      );

      await _sendOtpToEmail(email, generateOtp);

      //print("OTP sent successfully to $email");

      CustomSnackBar.showSnackBar(
        context: context,
        message: 'OTP Sent Succesfully to $email',
        color: kGreenColor, // Set the color of the SnackBar
      );

      isOtpLoading = false; 

      // Dismiss progress dialog
      Navigator.of(context).pop();

      _showOtpDialog(email);
    } catch (e) {
      //print("Failed to send OTP: $e");
      isOtpLoading = false;
      // Dismiss progress dialog
      Navigator.of(context).pop();

      setState(() {
        CustomSnackBar.showSnackBar(
          context: context,
          message: "Failed to send OTP: $e",
          color: kGreenColor, // Set the color of the SnackBar
        );

        //errorMessage = "Failed To Send OTP Please Try Again.";
      });
    } finally {
      setState(() {
        isOtpLoading = false;
      });
    }
  }

  Future<void> _sendOtpToEmail(String email, int otp) async {
    // Your SMTP server credentials
    String username = 'shivamg@itio.in'; // Replace with your email
    String password =
        '08F302E2946734E5198AC39C662EDFDA76BE'; // Replace with your email password or app-specific password

    // SMTP server configuration
    final smtpServer = SmtpServer(
      'smtp.elasticemail.com', // Use your SMTP server (e.g., Gmail's server)
      port: 2525, // SMTP port
      username: username,
      password: password,
    );

    // Email content
    final message = Message()
      ..from = Address(username, 'quickcash')
      ..recipients.add(email) // Recipient email
      ..subject = 'quickcash OTP Verification' // Email subject
      ..html = '''
      <div style="font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2">
        <div style="margin:50px auto;width:70%;padding:20px 0">
          <div style="border-bottom:1px solid #eee">
            <a href="" style="font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600">$email</a>
          </div>
          <p style="font-size:1.1em">Hi,</p>
          <p>Thank you for choosing quickcash. Use the following OTP to Verify Your Email ID. OTP is valid for 5 minutes:</p>
          <h2 style="background: #00466a;margin: 0 auto;width: max-content;padding: 0 10px;color: #fff;border-radius: 4px;">
            $otp
          </h2>
          <p style="font-size:0.9em;">Regards,<br/>quickcash</p>
          <hr style="border:none;border-top:1px solid #eee" />
        </div>
      </div>
    ''';

    try {
      // Send the email
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }

    print("Sending OTP $otp to email $email");
  }

  void _showOtpDialog(String email) {
    showDialog(
      //useSafeArea: true,
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 450,
            width: 600,
            child: Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: OTPSCREEN(
                email: email,
                generatedOtp: generateOtp,
                onVerified: _onOtpVerified,
              ),
            ),
          ),
        );
      },
    );
  }

  void _onOtpVerified(bool success) {
    Navigator.of(context).pop(); // Close the dialog
    if (success) {
      setState(() {
        isVerified = true; // Mark the email as verified
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            style: const TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.w500),
            onSaved: (value) {
              fullName = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }

              return null;
            },
            decoration: const InputDecoration(
              hintText: "Full Name",
              hintStyle: TextStyle(color: kHintColor),
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              style: TextStyle(
                  color: isVerified ? Colors.black26 : kPrimaryColor,
                  fontWeight: FontWeight.w500),
              onSaved: (value) {
                email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // Regex for valid email
                final regex = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                );
                if (!regex.hasMatch(value.trim())) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: "Your Email",
                  hintStyle: const TextStyle(color: kHintColor),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(
                      Icons.email,
                      color: isVerified ? Colors.black26 : kPrimaryColor,
                    ),
                  ),
                  suffixIcon: isVerified
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      : null,
                  fillColor: isVerified ? Colors.black12 : kPrimaryLightColor),
              enabled: !isVerified,
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            obscureText: _obsecureText,
            cursorColor: kPrimaryColor,
            style: const TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.w500),
            onSaved: (value) {
              password = value;
            },
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
              hintStyle: const TextStyle(color: kHintColor),
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
          const SizedBox(
            height: defaultPadding,
          ),
          GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  setState(() {
                    selectedCountry = country.name; // Set the selected country
                  });
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Selected Country: ${country.name}')),
                  // );
                },
              );
            },
            child: TextFormField(
              textInputAction: TextInputAction.done,
              enabled: false, // Disable direct text entry
              controller: TextEditingController(text: selectedCountry),
              cursorColor: kPrimaryColor,
              style: const TextStyle(
                  color: kPrimaryColor, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: selectedCountry ?? "Select Country",
                hintStyle: const TextStyle(color: kHintColor),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.flag),
                ),
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          const SizedBox(height: 40),
          if (isLoading)
            const CircularProgressIndicator(
              color: kPrimaryColor,
            ), // Show loading indicator
          if (errorMessage != null) // Show error message if there's an error
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
          const SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
            onPressed: isLoading ? null : mSignUp,
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
