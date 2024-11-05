import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

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
  String? selectedCountry;

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
          ElevatedButton(
            onPressed: () {
              if (_fromKey.currentState!.validate()) {
                _fromKey.currentState!.save();

                if(selectedCountry !="Select Country"){
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Please Select Country')),
                   );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Else}')),
                  );
                }
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
