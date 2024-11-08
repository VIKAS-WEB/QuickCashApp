import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/add_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/TransactionListModel/transactionListApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/TransactionListModel/transactionListModel.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/exchange_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/send_money_screen.dart';
import 'package:quickcash/components/background.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quickcash/constants.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
final TransactionListApi _transactionListApi = TransactionListApi();

  List<TransactionListDetails> transactionList = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState(){
    super.initState();
    mTransactionList();
  }

  Future<void> mTransactionList() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });


    try{

      final response = await _transactionListApi.transactionListApi();

      if(response.transactionList !=null && response.transactionList!.isNotEmpty){
        setState(() {
          transactionList = response.transactionList!;
          isLoading = false;
        });
      }else{
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



  void _navigateToDetail(String transactionID) {

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
    return Background(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25.0,),
            const Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IndicatorWidget(
                      label: "Deposit",
                      amount: 1008.22,
                      percentage: 0.75,
                      color: Colors.teal,
                      icon: Icons.arrow_upward,
                    ),
                    IndicatorWidget(
                      label: "Debit",
                      amount: 1008.552,
                      percentage: 0.75,
                      color: Colors.orange,
                      icon: Icons.arrow_downward,
                    ),
                    IndicatorWidget(
                      label: "Fee Debit",
                      amount: 1008.242,
                      percentage: 0.45,
                      color: Colors.purple,
                      icon: Icons.attach_money,
                    ),
                  ],
                ),
              ),
            ),

            // The Accounts design
            Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AccountCard(
                      flag: "🇺🇸",
                      currencyCode: "USD",
                      accountNumber: "US1000000001",
                      balance: "\$325.170",
                      accountName: "USD account",
                      bgColor: Colors.purple,
                    ),
                    const AccountCard(
                      flag: "🇪🇺",
                      currencyCode: "EUR",
                      accountNumber: "EU1000000004",
                      balance: "€19.766",
                      accountName: "Euro Account",
                      bgColor: Colors.white,
                    ),
                    const AccountCard(
                      flag: "🇮🇳",
                      currencyCode: "INR",
                      accountNumber: "IN1000000008",
                      balance: "₹300.000",
                      accountName: "INR account",
                      bgColor: Colors.white,
                    ),

                    const SizedBox(height: defaultPadding),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddMoneyScreen()),
                            );
                            // Add your onPressed code here!
                          },
                          label: const Text('Add Money',style: TextStyle(color: Colors.white),),
                          icon: const Icon(Icons.add,color: Colors.white,),
                          backgroundColor: kPrimaryColor,
                        ),

                        const SizedBox(width: 35),

                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ExchangeMoneyScreen()),
                            );
                          },
                          label: const Text(' Exchange  ',style: TextStyle(color: Colors.white),),
                          icon: const Icon(Icons.currency_exchange,color: Colors.white,),
                          backgroundColor: kPrimaryColor,
                        ),
                      ],
                    ),

                    const SizedBox(height: defaultPadding),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SendMoneyScreen()),
                            );
                            // Add your onPressed code here!
                          },
                          label: const Text('Send Money',style: TextStyle(color: Colors.white),),
                          icon: const Icon(Icons.send,color: Colors.white,),
                          backgroundColor: kPrimaryColor,
                        ),

                        const SizedBox(width: 30),
                        FloatingActionButton.extended(
                          onPressed: () {
                            // Add your onPressed code here!
                          },
                          label: const Text('All Account',style: TextStyle(color: Colors.white),),
                          icon: const Icon(Icons.select_all,color: Colors.white,),
                          backgroundColor: kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Transaction List Design
            const SizedBox(
              height: largePadding,
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              "Transaction List",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            ),
            const SizedBox(
              height: smallPadding,
            ),
            Column(
              children: transactionList.map((transaction) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: kPrimaryColor, // Custom background color
                  child: InkWell(
                    onTap: () => _navigateToDetail(transaction.transactionId.toString()), // Navigate on tap
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
                              Text(formatDate(transaction.transactionDate),
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
                              Text("${transaction.transactionId}",
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
                              Text("${transaction.transactionType}",
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
                              Text("${transaction.transactionAmount}",
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
                              Text("${transaction.balance}",
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

                              OutlinedButton(
                                onPressed: (){},
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(_getStatusColor(transaction.transactionStatus!))
                                ),
                                child: Text("${transaction.transactionStatus}",
                                    style: const TextStyle(color: Colors.white)),),

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
          ],
        ),
      ),
    );
  }
}

// Account Card widget (adapted from the previous design)
class AccountCard extends StatelessWidget {
  final String flag;
  final String currencyCode;
  final String accountNumber;
  final String balance;
  final String accountName;
  final Color bgColor;

  const AccountCard({super.key,
    required this.flag,
    required this.currencyCode,
    required this.accountNumber,
    required this.balance,
    required this.accountName,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    flag,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    currencyCode,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: currencyCode == 'USD' ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                accountNumber,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: currencyCode == 'USD' ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                accountName,
                style: TextStyle(
                  fontSize: 14,
                  color: currencyCode == 'USD' ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          Text(
            balance,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: currencyCode == 'USD' ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Indicator Widget for Deposit, Debit, and Fee Debit
class IndicatorWidget extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;
  final Color color;
  final IconData icon;

  const IndicatorWidget({super.key,
    required this.label,
    required this.amount,
    required this.percentage,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 12.0,
          percent: percentage,
          center: Icon(icon, size: 30, color: color),
          progressColor: color,
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
