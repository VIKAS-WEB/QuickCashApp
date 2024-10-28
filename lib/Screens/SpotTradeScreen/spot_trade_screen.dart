import 'package:flutter/material.dart';
import 'package:quickcash/components/background.dart';

class SpotTradeScreen extends StatefulWidget {
  const SpotTradeScreen({super.key});

  @override
  State<SpotTradeScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<SpotTradeScreen> {

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
                Text('Spot Trade Screen'), // Placeholder for main content
              ),
            ),
          ],
        ),
      ),
    );
  }

}