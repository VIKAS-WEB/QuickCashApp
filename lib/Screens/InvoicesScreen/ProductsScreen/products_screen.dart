import 'package:flutter/material.dart';
import 'package:quickcash/components/background.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

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
                Text('Products Screen'), // Placeholder for main content
              ),
            ),
          ],
        ),
      ),
    );
  }

}