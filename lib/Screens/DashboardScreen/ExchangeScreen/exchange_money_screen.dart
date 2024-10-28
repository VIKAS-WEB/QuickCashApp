import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/review_exchange_money_screen.dart';
import 'package:quickcash/constants.dart';

class ExchangeMoneyScreen extends StatefulWidget {
  const ExchangeMoneyScreen({super.key});

  @override
  State<ExchangeMoneyScreen> createState() => _ExchangeMoneyScreen();
}

class _ExchangeMoneyScreen extends State<ExchangeMoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Exchange Money",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to PayRecipientsScreen when tapped
                            },
                            child: Card(
                              elevation: 1.0,
                              color: kPrimaryLightColor,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/profile_pic.png',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: defaultPadding),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'USD Account',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.navigate_next_rounded,
                                        color: kPrimaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            cursorColor: kPrimaryColor,
                            style: const TextStyle(color: kPrimaryColor),
                            decoration: InputDecoration(
                              prefixText: '\$ ', // Dollar sign as prefix
                              labelText: "Amount",
                              labelStyle: const TextStyle(color: kPrimaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            enabled: true,
                            // Disable editing
                            initialValue: '0', // Set a default value if needed
                          ),
                          const SizedBox(height: 30),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fee:",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$0",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Divider(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Balance:",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$5541.25",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Divider line
                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: kPrimaryLightColor,
                    ),
                    // Circular button
                    Material(
                      elevation: 6.0,
                      shape: const CircleBorder(),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_downward,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to PayRecipientsScreen when tapped
                            },
                            child: Card(
                              elevation: 1.0,
                              color: kPrimaryLightColor,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/profile_pic.png',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: defaultPadding),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'INR Account',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.navigate_next_rounded,
                                        color: kPrimaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: defaultPadding),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            cursorColor: kPrimaryColor,
                            style: const TextStyle(color: kPrimaryColor),
                            decoration: InputDecoration(
                              labelText: "Amount",
                              labelStyle: const TextStyle(color: kPrimaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            enabled: false,
                            // Disable editing
                            initialValue: '0', // Set a default value if needed
                          ),

                          const SizedBox(height: 30),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Will get exactly:",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Balance: \$1025",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),


                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ReviewExchangeMoneyScreen()),
                    );
                  },

                  child: const Text('Review Order', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
