import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class TransactionDetailPage extends StatelessWidget {
  final Map<String, String> transaction;

  const TransactionDetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        // Change back button color here
        title: const Text(
          "Transaction Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        // Added ScrollView here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Card(
                color: kPrimaryColor,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [

                      Center(
                        child: Text(
                          "Transaction Details",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Trans ID:",
                              style: TextStyle(color: Colors.white)),
                          Text("242464216390",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Requested Date:",
                              style: TextStyle(color: Colors.white)),
                          Text("2024-10-16 01:05:03 PM",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fee:", style: TextStyle(color: Colors.white)),
                          Text("₹0.00", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bill Amount:",
                              style: TextStyle(color: Colors.white)),
                          Text("₹800.00",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Transaction Type:",
                              style: TextStyle(color: Colors.white)),
                          Text("₹0.00", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("credit - Invoice:",
                              style: TextStyle(color: Colors.white)),
                          Text("₹0.00", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Card(
                color: kPrimaryColor,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [

                      Center(
                        child: Text(
                          "Sender Information",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sender Name:",
                              style: TextStyle(color: Colors.white)),
                          Text("User Name",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email:", style: TextStyle(color: Colors.white)),
                          Text("useremail@gmail.com",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sender Address:",
                              style: TextStyle(color: Colors.white)),
                          Text("Address",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                color: kPrimaryColor,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [

                      const Center(
                        child: Text(
                          "Receiver Information",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Receiver Name:",
                              style: TextStyle(color: Colors.white)),
                          Text("User Name",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account Number:",
                              style: TextStyle(color: Colors.white)),
                          Text("receivermail@gmail.com",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Receiver Address:",
                              style: TextStyle(color: Colors.white)),
                          Text("Address",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Transaction Status:", style: TextStyle(color: Colors.white)),
                          FilledButton.tonal(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text('Success',style: TextStyle(color: Colors.green),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                color: kPrimaryColor,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [

                      const Center(
                        child: Text(
                          "Bank Status",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),


                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bank TransID:",
                              style: TextStyle(color: Colors.white)),
                          Text("242464216390",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Trans Amt:",
                              style: TextStyle(color: Colors.white)),
                          Text("₹800",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Settel. Date:",
                              style: TextStyle(color: Colors.white)),
                          Text("2024-10-16 01:05:03 PM",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Transaction Status:", style: TextStyle(color: Colors.white)),
                          FilledButton.tonal(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text('Success',style: TextStyle(color: Colors.green),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
