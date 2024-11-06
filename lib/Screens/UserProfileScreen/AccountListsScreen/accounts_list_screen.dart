import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class AccountsListScreen extends StatefulWidget {
  const AccountsListScreen({super.key});

  @override
  State<AccountsListScreen> createState() => _AccountsListScreen();
}

class _AccountsListScreen extends State<AccountsListScreen> {
  // Sample data for the accounts
  final List<Map<String, String>> accountData = [
    {
      "currency": "USD",
      "iban": "US123456789",
      "bic": "USBANK1",
      "balance": "\$1500.00",
      "image": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmN0el3AEK0rjTxhTGTBJ05JGJ7rc4_GSW6Q&s', // Add image URL
    },
    {
      "currency": "EUR",
      "iban": "EU987654321",
      "bic": "EUBANK2",
      "balance": "€2000.00",
      "image": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmN0el3AEK0rjTxhTGTBJ05JGJ7rc4_GSW6Q&s', // Add image URL
    },
    {
      "currency": "GBP",
      "iban": "GB112233445",
      "bic": "GBBANK3",
      "balance": "£1000.00",
      "image": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmN0el3AEK0rjTxhTGTBJ05JGJ7rc4_GSW6Q&s', // Add image URL
    },
    // Add more accounts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(smallPadding),
        child: Column(
          children: [
            const SizedBox(height: largePadding),
            // Horizontal Scroll List of Account Data with Images
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,  // Makes the ListView only take as much space as it needs
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
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  account['image']!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            const SizedBox(height: 35),
                            const Divider(color: kWhiteColor),
                            const SizedBox(height: defaultPadding),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Currency: ${account['currency']}',
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
                                  '${account['iban']}',
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
                                  '${account['bic']}',
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
                                  '${account['balance']}',
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
    );
  }
}
