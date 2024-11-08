import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/TransactionListModel/transactionListApi.dart';
import 'package:quickcash/Screens/TransactionScreen/transaction_details_screen.dart';
import 'package:quickcash/constants.dart';
import 'package:intl/intl.dart';

import '../DashboardScreen/Dashboard/TransactionListModel/transactionListModel.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionListApi _transactionListApi = TransactionListApi();

  List<TransactionListDetails> transactionList = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mTransactionList();
  }

  Future<void> mTransactionList() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _transactionListApi.transactionListApi();

      if (response.transactionList != null &&
          response.transactionList!.isNotEmpty) {
        setState(() {
          transactionList = response.transactionList!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Transaction List';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Success':
        return Colors.green;
      case 'Failed':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return kPrimaryColor;
    }
  }

// Function to format the date
  String formatDate(String? dateTime) {
    if (dateTime == null) {
      return 'Date not available'; // Fallback text if dateTime is null
    }
    DateTime date = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(date);
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
                children: transactionList.map((transaction) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: kPrimaryColor, // Custom background color
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionDetailPage(
                              transactionId: transaction.transactionId, // Passing transactionId here
                            ),
                          ),
                        )
                      }, // Navigate on tap
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: defaultPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Date:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text(formatDate(transaction.transactionDate),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Transaction ID:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text("${transaction.transactionId}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Type:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text("${transaction.transactionType}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Amount:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text("${transaction.transactionAmount}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Balance:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text("${transaction.balance}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Status:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          _getStatusColor(
                                              transaction.transactionStatus!))),
                                  child: Text(
                                      "${transaction.transactionStatus}",
                                      style:
                                          const TextStyle(color: Colors.white)),
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
