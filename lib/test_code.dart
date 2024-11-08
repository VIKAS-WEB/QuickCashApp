import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/add_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/exchange_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/send_money_screen.dart';
import 'package:quickcash/components/background.dart';
import 'package:quickcash/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Simulate loading and error states
  bool isLoading = false;
  String? errorMessage;

  // Sample account data
  final List<Map<String, dynamic>> accountData = [
    {
      'currency': 'USD',
      'iban': 'US1000000001',
      'bicCode': 'USD12345',
      'amount': 325.170,
    },
    {
      'currency': 'EUR',
      'iban': 'EU1000000004',
      'bicCode': 'EUR67890',
      'amount': 19.766,
    },
    {
      'currency': 'INR',
      'iban': 'IN1000000008',
      'bicCode': 'INR112233',
      'amount': 300.000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25.0),

            // The Accounts design using ListView.builder
            Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Loading and Error Handling
                    if (isLoading)
                      const Center(child: CircularProgressIndicator()),
                    if (errorMessage != null)
                      Center(
                          child: Text(
                            errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          )),

                    // Account list (only when not loading and no error)
                    if (!isLoading && errorMessage == null && accountData.isNotEmpty)
                      SizedBox(
                        height: 250, // Set height for the horizontal list view
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: accountData.length,
                          itemBuilder: (context, index) {
                            var account = accountData[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(defaultPadding),
                                ),
                                child: Container(
                                  width: 320,
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: largePadding),

                                      // Currency code inside a circle
                                      Center(
                                        child: CircleAvatar(
                                          radius: 60, // Size of the circle
                                          backgroundColor: kPrimaryColor, // Background color of the circle
                                          child: Text(
                                            account['currency'] ?? 'N/A', // Display the currency code
                                            style: const TextStyle(
                                              fontSize: 30, // Font size of the currency code
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white, // Text color
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 35),
                                      const Divider(color: kWhiteColor),
                                      const SizedBox(height: defaultPadding),

                                      // Account details
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Currency: ${account['currency'] ?? 'N/A'}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: smallPadding),
                                          const Divider(color: kWhiteColor),
                                          const SizedBox(height: smallPadding),

                                          const Text(
                                            'IBAN / Routing / Account Number:',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          Text(
                                            account['iban'] ?? 'N/A',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: smallPadding),
                                          const Divider(color: kWhiteColor),
                                          const SizedBox(height: smallPadding),

                                          const Text(
                                            'BIC / IFSC:',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          Text(
                                            account['bicCode'] ?? 'N/A',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: smallPadding),
                                          const Divider(color: kWhiteColor),
                                          const SizedBox(height: smallPadding),

                                          const Text(
                                            'Balance:',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          Text(
                                            '${account['amount'] ?? 0.0}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Action buttons at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddMoneyScreen()),
                    );
                  },
                  label: const Text('Add Money', style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.add, color: Colors.white),
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
                  label: const Text('Exchange', style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.currency_exchange, color: Colors.white),
                  backgroundColor: kPrimaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





/*


 // Loading and Error Handling
            if (isLoading)
              const Center(child: CircularProgressIndicator()),
            if (errorMessage != null)
              Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  )),

            // Account list (only when not loading and no error)
            if (!isLoading && errorMessage == null && accountData.isNotEmpty)
              SizedBox(
                height: 190, // Set height for the horizontal list view
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: accountData.length,
                  itemBuilder: (context, index) {
                    var account = accountData[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 5,
                        color: kWhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Container(
                          width: 320,
                          padding: const EdgeInsets.all(defaultPadding),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                      'assets/icons/menu_crypto.png', // Ensure this path is correct
                                    ),
                                  ),
                                  Text(
                                    "USD",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                                  ),
                                ],
                              ),

                              SizedBox(height: defaultPadding,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "IBAN",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
                                  ),
                                  Text(
                                    "US1000000001",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
                                  ),
                                ],
                              ),

                              SizedBox(height: defaultPadding,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Balance",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
                                  ),
                                  Text(
                                    "362.5093297443351",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
                                  ),
                                ],
                              ),

                              Text(
                                "Default",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kGreeneColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),




* */
