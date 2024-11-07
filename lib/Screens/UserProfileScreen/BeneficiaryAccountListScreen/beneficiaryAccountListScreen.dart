import 'package:flutter/material.dart';

import '../../../constants.dart';

class BeneficiaryAccountListScreen extends StatefulWidget {
  const BeneficiaryAccountListScreen({super.key});

  @override
  State<BeneficiaryAccountListScreen> createState() => _BeneficiaryAccountListState();
}

class _BeneficiaryAccountListState extends State<BeneficiaryAccountListScreen> {
  final List<Map<String, String>> recentTrades = [
    {
      "currency": "USD",
      "iban": "LT955424154545454",
      "bic": "321456",
      "balance": "\$0.00018000"
    },
    {
      "currency": "USD",
      "iban": "LT955424154545454",
      "bic": "321456",
      "balance": "\$0.00018000"
    },
    {
      "currency": "USD",
      "iban": "LT955424154545454",
      "bic": "321456",
      "balance": "\$0.00018000"
    },
    {
      "currency": "USD",
      "iban": "LT955424154545454",
      "bic": "321456",
      "balance": "\$0.00018000"
    },
    {"currency": "USD",
      "iban": "LT955424154545454",
      "bic": "321456",
      "balance": "\$0.00018000"
    },

    // Add more trades here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),  // This will add padding to the entire screen body
        child: ListView.builder(
          itemCount: recentTrades.length,
          itemBuilder: (context, index) {
            final trade = recentTrades[index];
            return Container(
              margin: const EdgeInsets.only(bottom: defaultPadding),  // Margin for card spacing
              decoration: BoxDecoration(
                color: kWhiteColor,  // Background color of the container
                borderRadius: BorderRadius.circular(smallPadding),  // Rounded corners for the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: kPurpleColor,  // Purple border color
                  width: 1,  // Border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),  // Padding for content inside the container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Display currency code inside a circle
                    const Center(
                      child: CircleAvatar(
                        radius: 50, // Size of the circle
                        backgroundColor: kPrimaryColor, // Background color of the circle
                        child: Text(
                          'USD', // Display the currency code
                          style: TextStyle(
                            fontSize: 30, // Font size of the currency code
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: largePadding,),

                    const Text(
                      "Currency:",
                      style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${trade['currency']}",
                      style: const TextStyle(color: kPrimaryColor),
                    ),


                    const SizedBox(height: 8),  // Small space between rows
                    const Text(
                      "IBAN / Routing / Account Number",
                      style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${trade['iban']}",
                      style: const TextStyle(color: kPrimaryColor),
                    ),

                    const SizedBox(height: smallPadding,),

                    const Text(
                      "BIC / IFSC:",
                      style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${trade['bic']}",
                      style: const TextStyle(color: kPrimaryColor),
                    ),

                    const SizedBox(height: 8),  // Small space between rows
                    const Text(
                      "Balance:",
                      style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${trade['balance']}",
                      style: const TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
