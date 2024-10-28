import 'package:flutter/material.dart';
import 'package:quickcash/components/background.dart';

class InvoiceTransactionsScreen extends StatefulWidget {
  const InvoiceTransactionsScreen({super.key});

  @override
  State<InvoiceTransactionsScreen> createState() => _InvoiceTransactionsScreenState();
}

class _InvoiceTransactionsScreenState extends State<InvoiceTransactionsScreen> {

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SafeArea(
        child: Column(
          children: [
            // You can add more widgets below this Row if needed
            Expanded(
              child: Center(
                child:
                Text('Invoice Transaction Screen'), // Placeholder for main content
              ),
            ),
          ],
        ),
      ),
    );
  }

}