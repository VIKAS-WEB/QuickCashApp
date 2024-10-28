import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/BeneficiaryScreen/select_beneficiary_screen.dart';
import 'package:quickcash/constants.dart';

class ShowBeneficiaryScreen extends StatefulWidget {
  const ShowBeneficiaryScreen({super.key});

  @override
  State<ShowBeneficiaryScreen> createState() => _ShowBeneficiaryScreen();
}

class _ShowBeneficiaryScreen extends State<ShowBeneficiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Recipients",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Beneficiary",
                    style: TextStyle(color: kPrimaryColor,fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add,color: kPrimaryColor), // Replace with your desired icon
                    onPressed: () {
                      // Navigate to PayRecipientsScreen when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SelectBeneficiaryScreen()),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
