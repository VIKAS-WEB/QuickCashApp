import 'package:flutter/material.dart';
import 'package:quickcash/Screens/TransactionScreen/transaction_details_screen.dart';
import 'package:quickcash/constants.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  // Sample Transaction History
  final List<Map<String, String>> transactionHistory = [
    {
      'date': '2024-10-16',
      'trx': '242464216390',
      'type': 'Add Money',
      'amount': '+\$22.01',
      'balance': '\$555555.22',
      'status': 'Success',
    },
    {
      'date': '2024-10-15',
      'trx': '242464216389',
      'type': 'Withdraw',
      'amount': '-\$50.00',
      'balance': '\$555533.22',
      'status': 'Success',
    },
    {
      'date': '2024-10-14',
      'trx': '242464216388',
      'type': 'Add Money',
      'amount': '+\$100.00',
      'balance': '\$555583.22',
      'status': 'Success',
    },
    {
      'date': '2024-10-13',
      'trx': '242464216387',
      'type': 'Transfer',
      'amount': '-\$30.00',
      'balance': '\$555553.22',
      'status': 'Success',
    },
    {
      'date': '2024-10-12',
      'trx': '242464216386',
      'type': 'Payment',
      'amount': '-\$10.00',
      'balance': '\$555543.22',
      'status': 'Success',
    },
  ];

  void _navigateToDetail(Map<String, String> transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionDetailPage(transaction: transaction),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 88),
          const Center(
            child: Text(
              "Transaction History",
              style: TextStyle(color: kPrimaryColor, fontSize: 22),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: transactionHistory.map((transaction) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: kPrimaryColor, // Custom background color
                    child: InkWell(
                      onTap: () => _navigateToDetail(transaction), // Navigate on tap
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: defaultPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Date:",
                                    style: TextStyle(color: Colors.white, fontSize: 16)),
                                Text("${transaction['date']}",
                                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Transaction ID:",
                                    style: TextStyle(color: Colors.white, fontSize: 16)),
                                Text("${transaction['trx']}",
                                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Type:",
                                    style: TextStyle(color: Colors.white, fontSize: 16)),
                                Text("${transaction['type']}",
                                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Amount:",
                                    style: TextStyle(color: Colors.white, fontSize: 16)),
                                Text("${transaction['amount']}",
                                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Balance:",
                                    style: TextStyle(color: Colors.white, fontSize: 16)),
                                Text("${transaction['balance']}",
                                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Status:",
                                    style: TextStyle(color: Colors.white, fontSize: 16)),
                                FilledButton.tonal(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.white),
                                  ),
                                  child: Text("${transaction['status']}",
                                      style: const TextStyle(color: Colors.green)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
