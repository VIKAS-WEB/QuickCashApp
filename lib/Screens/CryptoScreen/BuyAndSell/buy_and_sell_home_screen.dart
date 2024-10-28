import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/crypto_sell_exchange_screen.dart';
import 'package:quickcash/constants.dart'; // Ensure this path is correct

class Transaction {
  final String coin;
  final String date;
  final String paymentType;
  final double noOfCoins;
  final String side;
  final double amount;
  final String status;

  Transaction({
    required this.coin,
    required this.date,
    required this.paymentType,
    required this.noOfCoins,
    required this.side,
    required this.amount,
    required this.status,
  });
}

class BuyAndSellScreen extends StatefulWidget {
  const BuyAndSellScreen({super.key});

  @override
  State<BuyAndSellScreen> createState() => _BuyAndSellScreenState();
}

class _BuyAndSellScreenState extends State<BuyAndSellScreen> {
  final List<Transaction> transactions = [
    Transaction(
      coin: 'Bitcoin',
      date: '2024-10-22',
      paymentType: 'Bank Transfer',
      noOfCoins: 0.14454,
      side: 'Buy',
      amount: 1.22,
      status: 'Completed',
    ),
    Transaction(
      coin: 'Bitcoin',
      date: '2024-10-22',
      paymentType: 'Bank Transfer',
      noOfCoins: 0.14454,
      side: 'Buy',
      amount: 1.22,
      status: 'Rejected',
    ),
    Transaction(
      coin: 'Ethereum',
      date: '2024-10-22',
      paymentType: 'Credit Card',
      noOfCoins: 0.5,
      side: 'Sell',
      amount: 2.5,
      status: 'Pending',
    ),
    // Add more transactions as needed
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return kPrimaryColor; // Default color if status is unknown
    }
  }

  // Method to show the dialog for requesting wallet address
  void _showRequestWalletAddressDialog() {
    String? selectedCoin; // Variable to hold selected coin
    List<String> coins = ['BNB', 'BTC', 'DOGE']; // List of coins

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Wallet Address'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPrimaryColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedCoin ?? "Select Coin", style: const TextStyle(color: kPrimaryColor)),
                          const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Open the dropdown when the container is tapped
                      RenderBox renderBox = context.findRenderObject() as RenderBox;
                      Offset offset = renderBox.localToGlobal(Offset.zero);

                      showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          offset.dx,
                          offset.dy + renderBox.size.height, // Position below the container
                          offset.dx + renderBox.size.width,
                          0.0,
                        ),
                        items: coins.map((String value) {
                          return PopupMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ).then((String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCoin = newValue; // Update the selected coin
                          });
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (selectedCoin != null) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Wallet address requested for $selectedCoin')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Buy / Sell Exchange",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CryptoBuyAnsSellScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Buy / Sell',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                ),
                const SizedBox(width: defaultPadding),
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _showRequestWalletAddressDialog, // Show dialog on press
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Request Wallet Address',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding),
          Expanded(
            child: transactions.isNotEmpty
                ? ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Coin: ${transaction.coin}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                'assets/icons/menu_crypto.png', // Ensure this path is correct
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Date:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(transaction.date, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Payment Type:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(transaction.paymentType, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("No Of Coins:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(transaction.noOfCoins.toString(), style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Side:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(transaction.side, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Amount:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("\$${transaction.amount}", style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Status:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            FilledButton.tonal(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(_getStatusColor(transaction.status)),
                              ),
                              child: Text(transaction.status, style: const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            )
                : const Center(child: Text("No transactions available.")),
          ),
        ],
      ),
    );
  }
}
