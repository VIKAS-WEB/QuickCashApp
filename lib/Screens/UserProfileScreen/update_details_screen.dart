import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';

class UpdateDetailsScreen extends StatefulWidget {
  const UpdateDetailsScreen({super.key});

  @override
  State<UpdateDetailsScreen> createState() => _UpdateDetailsScreenState();
}

class _UpdateDetailsScreenState extends State<UpdateDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  String selectedRole = 'Select Title';

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

                    // User Name
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      readOnly: false,
                      style: const TextStyle(color: kPrimaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),

                    // User Email
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      readOnly: false,
                      style: const TextStyle(color: kPrimaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Your Email",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),

                    // User Phone Number
                    const SizedBox(height: defaultPadding),
                    IntlPhoneField(
                      keyboardType: TextInputType.phone,
                      focusNode: FocusNode(),
                      style: const TextStyle(color: kPrimaryColor),
                      dropdownIcon: const Icon(Icons.arrow_drop_down, size: 28, color: kPrimaryColor),
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'NP',
                      onChanged: (phone) {},
                      validator: (value) {
                        if (value == null || value.completeNumber.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),

                    // User Address
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      readOnly: false,
                      style: const TextStyle(color: kPrimaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Address",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),

                    // Country State City
                    const SizedBox(height: defaultPadding),
                    CountryStateCityPicker(
                      country: country,
                      state: state,
                      city: city,
                      dialogColor: Colors.white,
                      textFieldDecoration: InputDecoration(
                        filled: true,
                        counterStyle: const TextStyle(color: kPrimaryColor),
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        hintStyle: const TextStyle(color: kPrimaryColor),
                        suffixIcon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),

                    // Postal Code
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      readOnly: false,
                      style: const TextStyle(color: kPrimaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your postal code';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Postal Code",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),

                    // Title
                    const SizedBox(height: defaultPadding),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      items: ['Select Title','CEO', 'CFO', 'President', 'Manager', 'Others'].map((String role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedRole = newValue!;
                        });
                      },
                    ),

                    // Update Button
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

                          if (country.text.isEmpty || state.text.isEmpty || city.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select country, state, and city')),
                            );
                          }else if(selectedRole == "Select Title") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select title')),
                            );

                          } else if(_formKey.currentState!.validate()){

                          }

                        },
                        child: const Text('Update', style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 35),
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
