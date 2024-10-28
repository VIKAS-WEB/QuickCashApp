import 'package:flutter/material.dart';
import '../../../constants.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  const Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/profile_pic.png'), // Replace with actual image asset
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

                  const Text(
                    'User Name',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: kPrimaryColor),
                  ),

                  const SizedBox(height: defaultPadding),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value){},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),

                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()
                      ),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),

                    decoration: InputDecoration(
                      labelText: "Your Email",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()
                      ),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),

                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()
                      ),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),

                    decoration: InputDecoration(
                      labelText: "Country",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()
                      ),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),

                    decoration: InputDecoration(
                      labelText: "Total Accounts",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()
                      ),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),

                    decoration: InputDecoration(
                      labelText: "Default Currency",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()
                      ),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),

                    decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()
                      ),
                    ),
                  ),

                  const SizedBox(height: 30.0),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
