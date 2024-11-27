import 'dart:io';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickcash/Screens/InvoicesScreen/Settings/SettingsScreen/model/settingsApi.dart';
import 'package:quickcash/constants.dart';

import '../../../../util/apiConstants.dart';
import '../../../../util/auth_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsApi _settingsApi = SettingsApi();


  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController invoicePrefixController = TextEditingController();
  TextEditingController regardsTextController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? imagePath;
  String? logoUrl;

  // Create a GlobalKey to manage form state
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    mSettingsDetails();
    super.initState();
  }

  Future<void> mSettingsDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try{
      final response = await _settingsApi.settingsApi();

      setState(() {

        companyNameController.text = response.companyName!;
        mobileController.text = response.mobile!;
        country.text = response.invoiceCountry!;
        state.text = response.state!;
        city.text = response.city!;
        postalCodeController.text = response.zipcode!;
        companyAddressController.text = response.address!;
        invoicePrefixController.text = response.prefix!;
        regardsTextController.text = response.regardstext!;
        logoUrl = '${ApiConstants.baseSettingsImageUrl}${AuthManager.getUserId()}/${response.logo}';

        isLoading = false;
        errorMessage = null;

      });

    }catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,  // Set the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: largePadding),

                if (errorMessage != null)
                  Text(errorMessage!,
                      style: const TextStyle(color: Colors.red)),

                // Company Name
                TextFormField(
                  controller: companyNameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your company name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Company Name",
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),

                // Phone Number
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (value) {},
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide()),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),

                ),


                /*IntlPhoneField(
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
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  initialCountryCode: 'NP',
                  onChanged: (phone) {},
                  validator: (value) {
                    if (value == null || value.completeNumber.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),*/

                // Country, State, City Picker
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
                    suffixStyle: const TextStyle(color: kPrimaryColor),
                    suffixIcon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    fillColor: Colors.transparent,
                  ),
                ),

                // Postal Code
                const SizedBox(height: largePadding),
                TextFormField(
                  controller: postalCodeController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  cursorColor: kPrimaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your zip code';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Zip Code",
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),

                // Company Address
                const SizedBox(height: largePadding),
                TextFormField(
                  controller: companyAddressController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  minLines: 6,
                  maxLines: 12,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a company address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Company Address",
                    labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),

                // Image Selection
                const SizedBox(height: largePadding),

                if(logoUrl !=null)
                Card(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: imagePath != null
                            ? Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        )
                            : Image.network(
                          logoUrl.toString(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                            if (image != null) {
                              setState(() {
                                imagePath = image.path; // Store the image path
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Image selected')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('No image selected.')),
                              );
                            }
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                else if(isLoading)
                  Card(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imagePath != null
                              ? Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          )
                              : Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmN0el3AEK0rjTxhTGTBJ05JGJ7rc4_GSW6Q&s',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (image != null) {
                                setState(() {
                                  imagePath =
                                      image.path; // Store the image path
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Image selected')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('No image selected.')),
                                );
                              }
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.edit,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                // Invoice Settings
                const SizedBox(height: largePadding),
                const Text("Invoice Settings", style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(color: kPrimaryLightColor),
                const SizedBox(height: defaultPadding),

                // Invoice Prefix
                TextFormField(
                  controller: invoicePrefixController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your invoice prefix';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Invoice Prefix",
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),

                // Regards Text
                const SizedBox(height: largePadding),
                TextFormField(
                  controller: regardsTextController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your regards text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Regards Text",
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),

                const SizedBox(height: 45),

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
                      // Validate the form
                      if (_formKey.currentState?.validate() ?? false) {
                        // Form is valid, perform necessary action
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form is valid')),
                        );
                      }
                    },
                    child: const Text('Update', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),

                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
