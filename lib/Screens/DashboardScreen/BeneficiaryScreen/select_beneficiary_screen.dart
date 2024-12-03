import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/BeneficiaryScreen/beneficiaryCurrencyModel/beneficiaryCurrencyApi.dart';
import 'package:quickcash/Screens/DashboardScreen/BeneficiaryScreen/beneficiaryCurrencyModel/beneficiaryCurrencyModel.dart';

import '../../../constants.dart';

class SelectBeneficiaryScreen extends StatefulWidget {
  const SelectBeneficiaryScreen({super.key});

  @override
  State<SelectBeneficiaryScreen> createState() => _SelectBeneficiaryScreen();
}

class _SelectBeneficiaryScreen extends State<SelectBeneficiaryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  final BeneficiaryCurrencyApi _beneficiaryCurrencyApi = BeneficiaryCurrencyApi();
  String? selectedCurrency;
  String? mCurrencyCode;
  List<BeneficiaryCurrencyData> currency = [];

  String? selectedCountry;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process payment here
    }
  }

  @override
  void initState() {
    super.initState();
    mGetCurrency();
  }

  Future<void> mGetCurrency() async {
    final response = await _beneficiaryCurrencyApi.beneficiaryCurrencyApi();

    if (response.data.isNotEmpty) {
      currency = response.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Beneficiary",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        style: const TextStyle(color: kPrimaryColor),
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          if (value.length < 3) {
                            return 'Name must be at least 3 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        style: const TextStyle(color: kPrimaryColor),
                        decoration: InputDecoration(
                          labelText: "Your Email",
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        style: const TextStyle(color: kPrimaryColor),
                        decoration: InputDecoration(
                          labelText: "Mobile Number",
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if (value.length < 10 || value.length > 15) {
                            return 'Mobile number must be between 10 to 15 digits';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        style: const TextStyle(color: kPrimaryColor),
                        decoration: InputDecoration(
                          labelText: "Bank Name",
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your bank name';
                          }
                          if (value.length < 3) {
                            return 'Bank name must be at least 3 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        style: const TextStyle(color: kPrimaryColor),
                        decoration: InputDecoration(
                          labelText: "IBAN / AC",
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your IBAN or account number';
                          }
                          // Add a specific length check for IBAN or account number
                          if (value.length < 8) {
                            return 'IBAN/AC must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        style: const TextStyle(color: kPrimaryColor),
                        decoration: InputDecoration(
                          labelText: "Routing/IFSC/BIC/SwiftCode",
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the routing number or equivalent';
                          }
                          // Add a specific length check for routing number
                          if (value.length < 6) {
                            return 'Routing number must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            onSelect: (Country country) {
                              setState(() {
                                selectedCountry = country.name; // Set the selected country
                              });
                            },
                          );
                        },
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          enabled: false, // Disable direct text entry
                          controller: TextEditingController(text: selectedCountry),
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor,),
                          decoration: InputDecoration(
                            labelText: 'Country',
                            hintText: selectedCountry ?? "Select Country",hintStyle: const TextStyle(color: kHintColor),
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            suffixIcon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor,),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),

                        ),
                      ),

                      const SizedBox(height: defaultPadding,),
                      GestureDetector(
                        onTap: () {
                          if (currency.isNotEmpty) {
                            showDialog<BeneficiaryCurrencyData>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Select Currency',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: currency.map((BeneficiaryCurrencyData currencyItem) {
                                        return ListTile(
                                          title: Text(
                                            currencyItem.currencyName,
                                            style: const TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context, currencyItem);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ).then((BeneficiaryCurrencyData? selectedItem) {
                              if (selectedItem != null) {
                                setState(() {
                                  selectedCurrency = selectedItem.currencyName;
                                  mCurrencyCode = selectedItem.currencyCode;
                                });
                              }
                            });
                          }
                        },
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: kPrimaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedCurrency ?? "Select Currency", // Show selected currency name
                                  style: const TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                              ],
                            ),
                          ),
                        ),
                      ),


                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        textInputAction: TextInputAction.none,
                        decoration: InputDecoration(
                          labelText: 'Recipient Address',
                          labelStyle: const TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        maxLines: 10,
                        minLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the recipient address';
                          }
                          return null;
                        },
                      ),
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
                          onPressed: _submitForm,
                          child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
