import 'dart:io';

import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quickcash/constants.dart';

class EditClientsFormScreen extends StatefulWidget {
  const EditClientsFormScreen({super.key});

  @override
  State<EditClientsFormScreen> createState() => _EditClientsFormScreenState();
}

class _EditClientsFormScreenState extends State<EditClientsFormScreen> {
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  String? imagePath; // Variable to store the selected image path

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Edit Client",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const SizedBox(height: defaultPadding,),
              const Center(
                child: Text("Edit Clients Form",style: TextStyle(color: kPrimaryColor,fontSize: 20,fontWeight: FontWeight.w500),),
              ),

              const SizedBox(height: largePadding,),
              // First Name
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: false,
                style: const TextStyle(color: kPrimaryColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "First Name",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),


              // Last Name
              const SizedBox(height: largePadding,),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: false,
                style: const TextStyle(color: kPrimaryColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Last Name",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),

              // User Email
              const SizedBox(height: largePadding),
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
                  labelText: "Email",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),

              // User Phone Number
              const SizedBox(height: largePadding),
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

              // Postal Code
              const SizedBox(height: largePadding),
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


              // Country State City
              const SizedBox(height: largePadding),
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

              const SizedBox(height: largePadding,),
              TextFormField(
                keyboardType: TextInputType.text,
                cursorColor: kPrimaryColor,
                textInputAction: TextInputAction.none,
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                ),
                maxLines: 5,
                minLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                  return null; // Validation passed
                },
              ),

              const SizedBox(height: largePadding,),
              TextFormField(
                keyboardType: TextInputType.text,
                cursorColor: kPrimaryColor,
                textInputAction: TextInputAction.none,
                decoration: InputDecoration(
                  labelText: 'Notes',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                ),
                maxLines: 5,
                minLines: 1,
              ),

              const SizedBox(height: largePadding,),
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
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmN0el3AEK0rjTxhTGTBJ05JGJ7rc4_GSW6Q&s',
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

                  },
                  child: const Text('Save', style: TextStyle(color: Colors.white,fontSize: 16)),
                ),
              ),

              const SizedBox(height: 35),

            ],
          ),
        ),
      ),
    );
  }
}