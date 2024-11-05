import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:quickcash/Screens/SignupScreen/model/signupApi.dart';

import '../../../components/check_already_have_an_account.dart';
import '../../../constants.dart';
import '../../../util/auth_manager.dart';
import '../../LoginScreen/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? email;
  String? password;
  String? selectedCountry;

  final SignUpApi _signUpApi = SignUpApi();

  bool isLoading = false;
  String? errorMessage;

  bool _isPasswordValid(String password) {
    // Regex to check password criteria
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
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
              fullName!,
              email!,
              password!,
              selectedCountry!,
              ""
          );

          if (response.userId != null) {
            print("User ID: ${response.userId}");
          } else {
            print("User ID is null");
          }

          print(response.token);

          setState(() {
            isLoading = false;
          });

          // Save user ID and token to SharedPreferences
          await AuthManager.saveUserId(response.userId!);
          await AuthManager.saveToken(response.token!);

          // Navigate to HomeScreen (uncomment this and replace with actual HomeScreen)
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const HomeScreen()),
          // );

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
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
              hintText: "Full Name",hintStyle: TextStyle(color: kHintColor),
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
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
                hintText: "Your Email",hintStyle: TextStyle(color: kHintColor),
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
            style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
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
            decoration: const InputDecoration(
              hintText: "Your Password",hintStyle: TextStyle(color: kHintColor),
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
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
              style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: selectedCountry ?? "Select Country",hintStyle: const TextStyle(color: kHintColor),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.flag),
                ),
                suffixIcon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor,),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          const SizedBox(height: 40),
          if (isLoading) const CircularProgressIndicator(color: kPrimaryColor,), // Show loading indicator
          if (errorMessage != null) // Show error message if there's an error
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: defaultPadding,),
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
