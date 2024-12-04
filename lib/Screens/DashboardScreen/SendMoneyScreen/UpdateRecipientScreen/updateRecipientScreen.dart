import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class UpdateRecipientScreen extends StatefulWidget {
  const UpdateRecipientScreen({super.key});

  @override
  State<UpdateRecipientScreen> createState() => _UpdateRecipientScreenState();
}

class _UpdateRecipientScreenState extends State<UpdateRecipientScreen>{
  TextEditingController mIban = TextEditingController();
  TextEditingController mBicCode = TextEditingController();
  TextEditingController mCurrency = TextEditingController();
  TextEditingController mAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Beneficiary Account Details", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: mIban,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              style: const TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                labelText: "IBAN / Account Number",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: mBicCode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
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
            ),

            const SizedBox(height: defaultPadding),

            TextFormField(
              controller: mCurrency,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Currency",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: defaultPadding),


            TextFormField(
              controller: mAmount,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                labelText: "Enter Amount",
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
                  return 'Please enter amount';
                }

                return null;
              },
            ),
          ],
        ),),
      ),
    );
  }

}