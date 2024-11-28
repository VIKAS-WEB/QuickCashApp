import 'dart:math';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/add_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/AllAccountsScreen/allAccountsScreen.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountListTransactionApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListModel.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/TransactionList/transactionListApi.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/exchange_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/send_money_screen.dart';
import 'package:quickcash/Screens/TransactionScreen/TransactionDetailsScreen/transaction_details_screen.dart';
import 'package:quickcash/components/background.dart';
import 'package:quickcash/constants.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/util/auth_manager.dart';

import '../../LoginScreen/login_screen.dart';
import 'RevenueList/revenueListApi.dart';
import 'TransactionList/transactionListModel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TransactionListApi _transactionListApi = TransactionListApi();
  final AccountsListApi _accountsListApi = AccountsListApi();
  final AccountListTransactionApi _accountListTransactionApi = AccountListTransactionApi();
  final RevenueListApi _revenueListApi = RevenueListApi();

  List<AccountsListsData> accountsListData = [];
  List<TransactionListDetails> transactionList = [];
  bool isLoading = false;
  bool isTransactionLoading = false;
  String? errorTransactionMessage;
  String? errorMessage;
  int? _selectedIndex;
  double? creditAmount;
  double? debitAmount;
  double? investingAmount;
  double? earningAmount;

  @override
  void initState() {
    super.initState();
    mAccounts();
    mRevenueList();
    mTransactionList();
  }

  // Accounts List Api ---------------
  Future<void> mAccounts() async {
    setState(() {
      //isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _accountsListApi.accountsListApi();

      if (response.accountsList != null && response.accountsList!.isNotEmpty) {
        setState(() {
          accountsListData = response.accountsList!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Account Found';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();

        mTokenExpireDialog();
      });
    }
  }

  // Account List Transaction Api ------
  Future<void> mAccountListTransaction(accountId, currency) async {
    setState(() {
      //isTransactionLoading = true;
      errorTransactionMessage = null;
    });

    try{
      final response = await _accountListTransactionApi.accountListTransaction(accountId, currency, AuthManager.getUserId());
      if (response.transactionList != null &&
          response.transactionList!.isNotEmpty) {
        setState(() {
          transactionList = response.transactionList!;
          isTransactionLoading = false;
        });
      } else {
        setState(() {
          isTransactionLoading = false;
          errorTransactionMessage = 'No Transaction List';
        });
      }
    }catch (error) {
      setState(() {
        isTransactionLoading = false;
        errorTransactionMessage = error.toString();
      });
    }
  }

  // Revenue List Api ------------
  Future<void> mRevenueList() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    try{
      final response = await _revenueListApi.revenueListApi();

      creditAmount = response.creditAmount ?? 0.0;
      debitAmount = response.debitAmount ?? 0.0;
      investingAmount = response.investingAmount ?? 0.0;
      earningAmount = response.earningAmount ?? 0.0;


    }catch (error) {
      setState(() {
        isLoading = false;
        errorTransactionMessage = error.toString();
      });
    }
  }

  // Transaction List Api   ------
  Future<void> mTransactionList() async {
    setState(() {
     // isTransactionLoading = true;
      errorTransactionMessage = null;
    });

    try {
      final response = await _transactionListApi.transactionListApi();

      if (response.transactionList != null &&
          response.transactionList!.isNotEmpty) {
        setState(() {
          transactionList = response.transactionList!;
          isTransactionLoading = false;
        });
      } else {
        setState(() {
          isTransactionLoading = false;
          errorTransactionMessage = 'No Transaction List';
        });
      }
    } catch (error) {
      setState(() {
        isTransactionLoading = false;
        errorTransactionMessage = error.toString();
      });
    }
  }

/*  // Transaction Status Color
  Color _getStatusColor(String? status) {
    if (status == null) return kPrimaryColor;
    switch (status.toLowerCase()) {  // Convert status to lowercase for consistency
      case 'success':
      case 'succeeded':
        return Colors.green;
      case 'failed':
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return kPrimaryColor; // Fallback for unexpected status values
    }
  }*/




// Function to format the date
  String formatDate(String? dateTime) {
    if (dateTime == null) {
      return 'Date not available'; // Fallback text if dateTime is null
    }
    DateTime date = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(date);
  }


  Future<bool> mTokenExpireDialog() async {
    return (await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: kPrimaryColor,
      builder: (context) => AlertDialog(
        title: const Text("Login Again"),
        content: const Text("Token has been expired, Please Login Again!"),
        actions: <Widget>[
          /*TextButton(
            onPressed: () => Navigator.of(context).pop(false), // No, return false
            child: const Text("No"),
          ),*/
          TextButton(
            onPressed: () async {
              // Log the user out
              AuthManager.logout();  // Make sure to call logout function here
              // Pop the dialog and return true (indicating a successful logout)
              Navigator.of(context).pop(true);
              // Navigate to the login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), // replace HomeScreen with your actual home screen
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    )) ?? false; // In case of dialog dismiss, return false
  }



  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(), // Show loading indicator
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25.0,
            ),

            if (isLoading) const Center(child: CircularProgressIndicator()),

            const SizedBox(height: largePadding,),

             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    GaugeContainer(
                      child: GaugeWidget(
                        label: 'Credit',
                        currentAmount: creditAmount ?? 0.0,
                        totalAmount: creditAmount ?? 0.0,
                        color: Colors.green,
                        icon: Icons.arrow_downward_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GaugeContainer(
                      child: GaugeWidget(
                        label: 'Debit',
                        currentAmount: debitAmount ?? 0.0,
                        totalAmount: creditAmount ?? 0.0,
                        color: Colors.red,
                        icon: Icons.arrow_upward_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GaugeContainer(
                      child: GaugeWidget(
                        label: 'Investing',
                        currentAmount: investingAmount ?? 0.0,
                        totalAmount: creditAmount ?? 0.0,
                        color: Colors.purple,
                        icon: Icons.attach_money,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GaugeContainer(
                      child: GaugeWidget(
                        label: 'Earning',
                        currentAmount: earningAmount ?? 0.0,
                        totalAmount: creditAmount ?? 0.0,
                        color: Colors.lightGreen,
                        icon: Icons.attach_money,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: smallPadding,),

            // Loading and Error Handling
            if (isLoading) const Center(child: CircularProgressIndicator()),
            if (errorMessage != null)
              Center(
                  child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              )),

            // Account list (only when not loading and no error)
            if (!isLoading &&
                errorMessage == null &&
                accountsListData.isNotEmpty)

            SizedBox(
              height: 170, // Set height for the horizontal list view
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: accountsListData.length,
                itemBuilder: (context, index) {
                  final accountsData = accountsListData[index];
                  final isSelected = index == _selectedIndex;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          mAccountListTransaction(accountsData.accountId, accountsData.currency);
                        });
                      },
                      child: Card(
                        elevation: 5,
                        color: isSelected ? kPrimaryColor : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Container(
                          width: 320,
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CountryFlag.fromCountryCode(
                                    width: 35,
                                    height: 35,
                                    accountsData.country!,
                                    shape: const Circle(),
                                  ),
                                  Text(
                                    "${accountsData.currency}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "IBAN",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${accountsData.iban}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Balance",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${accountsData.amount}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // The Accounts design ----------------
            Card(
              margin: const EdgeInsets.all(16.0),
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddMoneyScreen()),
                            );
                            // Add your onPressed code here!
                          },
                          label: const Text(
                            'Add Money',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          backgroundColor: kPrimaryColor,
                        ),
                        const SizedBox(width: 35),
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ExchangeMoneyScreen()),
                            );
                          },
                          label: const Text(
                            ' Exchange  ',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.currency_exchange,
                            color: Colors.white,
                          ),
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
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SendMoneyScreen()),
                            );
                            // Add your onPressed code here!
                          },
                          label: const Text(
                            'Send Money',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          backgroundColor: kPrimaryColor,
                        ),
                        const SizedBox(width: 30),
                        FloatingActionButton.extended(
                          onPressed: () {
                            // Add your onPressed code here!
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                   const AllAccountsScreen()),
                            );
                          },
                          label: const Text(
                            'All Account',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.select_all,
                            color: Colors.white,
                          ),
                          backgroundColor: kPrimaryColor,
                        ),
                      ],
                    ),

                    const SizedBox(height: smallPadding,),

                  ],
                ),
              ),
            ),

            // Transaction List Design
            const SizedBox(
              height: largePadding,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                "Recent Transaction ",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: smallPadding,
            ),

            // Loading and Error Handling
            if (isTransactionLoading) const Center(child: CircularProgressIndicator()),
            if (errorTransactionMessage != null)


              SizedBox(height: 190,
              child: Padding(padding: const EdgeInsets.all(largePadding),
              child: Card(
                color: kPrimaryColor,
                elevation: 4,
                child: Center(
                    child: Text(
                      errorTransactionMessage!,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),)
              ),

            // Account list (only when not loading and no error)
            if (!isTransactionLoading &&
                errorTransactionMessage == null &&
                transactionList.isNotEmpty)

              Column(
                children: transactionList.take(2).map((transaction) { // Limiting to 5 items
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: kPrimaryColor, // Custom background color
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionDetailPage(
                              transactionId: transaction.trxId, // Passing transactionId here
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
                                Text("${transaction.transactionId}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text(formatDate(transaction.transactionDate),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${transaction.transactionType}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text("${transaction.fromCurrency} ${transaction.amount}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${transaction.balance}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text(
                                  (transaction.transactionStatus?.isNotEmpty ?? false)
                                      ? '${transaction.transactionStatus![0].toUpperCase()}${transaction.transactionStatus!.substring(1)}'
                                      : 'Unknown', // Fallback to 'Unknown' if null or empty
                                  style: const TextStyle(color: Colors.white),
                                )

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

class GaugeContainer extends StatelessWidget {
  final Widget child;

  const GaugeContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 112,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class GaugeWidget extends StatelessWidget {
  final String label;
  final double currentAmount;
  final double totalAmount;
  final Color color; // Color for the gauge and text
  final IconData icon;

  const GaugeWidget({
    super.key,
    required this.label,
    required this.currentAmount,
    required this.totalAmount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (currentAmount / totalAmount).clamp(0.0, 1.0);

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(100, 120),
          painter: GaugePainter(percentage: percentage, color: color),
        ),
        // Centered Column with Icon on top and Text below
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // If you want to show the icon, uncomment the following line
            const SizedBox(height: largePadding,),
            Icon(
              icon,
              size: 20, // Icon size
              color: color,
            ),
            const SizedBox(height: 0), // Space between icon and text
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color, // Set the text color to the received color
              ),
            ),
            Text(
              '\$${currentAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color, // Set the text color to the received color
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class GaugePainter extends CustomPainter {
  final double percentage;
  final Color color;

  GaugePainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40.0;

    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40.0;

    // Draw the background arc (representing the full gauge)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      pi, // Start angle (180 degrees)
      pi, // Sweep angle (180 degrees)
      false,
      backgroundPaint,
    );

    // Draw the progress arc (representing the percentage filled)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      pi, // Start angle
      pi * percentage, // Sweep angle based on percentage
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
