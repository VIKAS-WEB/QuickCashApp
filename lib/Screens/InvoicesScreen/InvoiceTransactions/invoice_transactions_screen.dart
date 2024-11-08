import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class InvoiceTransactionsScreen extends StatefulWidget {
  const InvoiceTransactionsScreen({super.key});

  @override
  State<InvoiceTransactionsScreen> createState() => _InvoiceTransactionsScreenState();
}

class _InvoiceTransactionsScreenState extends State<InvoiceTransactionsScreen> {

  final List<Map<String, String>> invoiceTransactionList = [
    {
      'invoiceNumber': 'ITIOXX9X9O18958',
      'paymentDate': '2024-10-20',
      'total': '1008',
      'paidAmount': '10555508',
      'transactionType': 'Manual',
    },
    {
      'invoiceNumber': 'ITIOXX9X9O189566571',
      'paymentDate': '2024-10-23',
      'total': '10708',
      'paidAmount': '100558',
      'transactionType': 'Manual',
    },
    // You can add more card entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
            "Invoice Transaction",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: largePadding,),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: invoiceTransactionList.length,
              itemBuilder: (context, index) {
                final card = invoiceTransactionList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding), // Add spacing
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Invoice Number:', style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text('${card['invoiceNumber']}', style: const TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),

                        const SizedBox(height: smallPadding,),
                        const Divider(color: kPrimaryLightColor,),
                        const SizedBox(height: smallPadding,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Payment Date:',style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text('${card['paymentDate']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),

                        const SizedBox(height: smallPadding,),
                        const Divider(color: kPrimaryLightColor,),
                        const SizedBox(height: smallPadding,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total:',style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text('${card['total']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),

                        const SizedBox(height: smallPadding,),
                        const Divider(color: kPrimaryLightColor,),
                        const SizedBox(height: smallPadding,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Paid Amount:',style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text('${card['paidAmount']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),

                        const SizedBox(height: smallPadding,),
                        const Divider(color: kPrimaryLightColor,),
                        const SizedBox(height: smallPadding,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Transaction Type:',style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text('${card['transactionType']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),



                        const SizedBox(height: smallPadding,),
                      ],
                    ),
                  ),
                );
              },
            ),

          ],
        ),
        ),
      ),
    );
  }

}