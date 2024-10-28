import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class WalletAddressScreen extends StatefulWidget {
  const WalletAddressScreen({super.key});

  @override
  State<WalletAddressScreen> createState() => _WalletAddressScreenState();
}

class _WalletAddressScreenState extends State<WalletAddressScreen> {
  final List<String> walletTypes = ["ADA", "BTC", "ETH", "LTC"];
  final List<String> walletBalances = ["0", "0.99988454", "1.154665", "0.999880000"]; // Example balances

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Wallet Address",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView.builder(
          itemCount: walletTypes.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          walletTypes[index],
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'assets/images/profile_pic.png', // Replace with actual image asset
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          walletBalances[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
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
