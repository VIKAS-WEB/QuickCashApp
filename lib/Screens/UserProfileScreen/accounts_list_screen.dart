import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class AccountsListScreen extends StatefulWidget {
  const AccountsListScreen({super.key});

  @override
  State<AccountsListScreen> createState() => _AccountsListScreen();
}

class _AccountsListScreen extends State<AccountsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [

                  const SizedBox(height: 45),

                  const Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 110,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmN0el3AEK0rjTxhTGTBJ05JGJ7rc4_GSW6Q&s',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Currency",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
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
                      labelText: "IBAN / Routing / Account Number",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
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
                      labelText: "BIC / IFSC",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
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
                      labelText: "Balance",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
