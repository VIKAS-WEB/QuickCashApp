import 'package:flutter/material.dart';
import 'package:quickcash/components/background.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

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
                Text('Settings Screen'), // Placeholder for main content
              ),
            ),
          ],
        ),
      ),
    );
  }

}