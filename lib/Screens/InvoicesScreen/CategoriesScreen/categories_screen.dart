import 'package:flutter/material.dart';
import 'package:quickcash/components/background.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

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
                Text('Categories Screen'), // Placeholder for main content
              ),
            ),
          ],
        ),
      ),
    );
  }

}