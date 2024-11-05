import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/add_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/exchange_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/send_money_screen.dart';
import 'package:quickcash/components/background.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quickcash/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // New card with indicator widgets for Deposit, Debit, and Fee Debit

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
            const Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Transaction List",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Date of Transaction"),
                        Text("2024-10-09"),
                      ],
                    ),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Trx"),
                        Text("255554445454544"),
                      ],
                    ),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Type"),
                        Text("Add Money",style: TextStyle(color: Colors.green),),
                      ],
                    ),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Amount"),
                        Text("+\$3565545455.21",style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),),
                      ],
                    ),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Balance"),
                        Text("\$3325.20",),
                      ],
                    ),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Status"),
                        Text("Success",style: TextStyle(color: Colors.green),),
                      ],
                    ),

                  ],
                ),
              ),
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
