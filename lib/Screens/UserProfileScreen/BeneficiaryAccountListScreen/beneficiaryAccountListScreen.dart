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
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:28 PM"
    },
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:38 PM"
    },
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:38 PM"
    },
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:38 PM"
    },
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:38 PM"
    },
    // Add more trades here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simple list using Column without scroll
          Expanded(
            child: ListView.builder(
              itemCount: recentTrades.length,
              itemBuilder: (context, index) {
                final trade = recentTrades[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: smallPadding),
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kPurpleColor, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Price (USDT):", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                          Text("${trade['price']}", style: const TextStyle(color: kPrimaryColor)),
                        ],
                      ),
                      const SizedBox(height: smallPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Qty (BTC):", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                          Text("${trade['quantity']}", style: const TextStyle(color: kPrimaryColor)),
                        ],
                      ),
                      const SizedBox(height: smallPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Time:", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                          Text("${trade['time']}", style: const TextStyle(color: kPrimaryColor)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
