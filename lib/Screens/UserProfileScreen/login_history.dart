import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class LoginHistoryScreen extends StatefulWidget {
  const LoginHistoryScreen({super.key});

  @override
  State<LoginHistoryScreen> createState() => _LoginHistoryScreen();
}

class _LoginHistoryScreen extends State<LoginHistoryScreen> {
  // Sample login history data
  final List<Map<String, String>> loginHistory = [
    {
      'date': 'October 17th 2024, 9:35:34 AM',
      'device': 'Google Chrome',
      'os': 'Windows',
      'ip': '172.31.2.161',
    },
    {
      'date': 'October 16th 2024, 12:13:28 PM',
      'device': 'Microsoft Edge',
      'os': 'Windows',
      'ip': '172.31.2.161',
    },
    {
      'date': 'October 16th 2024, 12:04:02 PM',
      'device': 'Microsoft Edge',
      'os': 'Windows',
      'ip': '172.31.2.161',
    },
    {
      'date': 'October 16th 2024, 10:26:57 AM',
      'device': 'Google Chrome',
      'os': 'Windows',
      'ip': '172.31.2.161',
    },
    {
      'date': 'October 16th 2024, 9:34:10 AM',
      'device': 'Microsoft Edge',
      'os': 'Windows',
      'ip': '172.31.2.161',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16.0), // Adjust the height as needed
          Expanded(
            child: ListView.builder(
              itemCount: loginHistory.length,
              itemBuilder: (context, index) {
                final history = loginHistory[index];
                return Card(
                  color: kPrimaryColor, // Change this to your desired color
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${history['date']!}', style: const TextStyle(fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text('Device: ${history['device']!}', style: const TextStyle(fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text('OS: ${history['os']!}', style: const TextStyle(fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text('IP Address: ${history['ip']!}', style: const TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
