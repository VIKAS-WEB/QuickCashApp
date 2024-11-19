import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class ViewClientsScreen extends StatefulWidget {
  final String? clientsID;
  const ViewClientsScreen({super.key,required this.clientsID});

  @override
  State<ViewClientsScreen> createState() => _ViewClientsScreenState();
}

class _ViewClientsScreenState extends State<ViewClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "View Client",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  const Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/images/profile_pic.png'), // Replace with actual image asset
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

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
                      labelText: "Email",
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
                      labelText: "Postal Code",
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

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),

                    decoration: InputDecoration(
                      labelText: "Note",
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
                      labelText: "Last Update",
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