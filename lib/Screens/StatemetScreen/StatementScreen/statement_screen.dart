import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/StatemetScreen/StatementDetailsScreen/statement_details_screen.dart';
import 'package:quickcash/Screens/StatemetScreen/StatementScreen/model/statementApi.dart';
import 'package:quickcash/constants.dart';

import '../../DashboardScreen/Dashboard/TransactionList/transactionListModel.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  final StatementListApi _statementListApi = StatementListApi();

  List<TransactionListDetails> statementList = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mStatementList();
  }

  Future<void> mStatementList() async {

    setState(() {
      isLoading = true;
      errorMessage = null;
    });


    try {
      final response = await _statementListApi.statementListApi();
      if (response.transactionList != null &&
          response.transactionList!.isNotEmpty) {
        setState(() {
          statementList = response.transactionList!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Statement List';
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
      case 'succeeded':
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
          const SizedBox(height: 75),
          const SizedBox(height: defaultPadding),
          Expanded(
            child: isLoading ? const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ) :  SingleChildScrollView(
              child: Column(
                children: statementList.map((transaction) {
                  return Card(
                    margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: kPrimaryColor, // Custom background color
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatementDetailsScreen(
                              transactionId: transaction.trxId, // Passing transactionId here
                            ),
                          ),
                        ),

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
