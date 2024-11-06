import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color color,
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white), // You can adjust text color here.
        ),
        backgroundColor: color,  // Custom background color
        /*action: SnackBarAction(
          label: 'Action',
          textColor: Colors.white, // Custom text color for action button
          onPressed: () {
            // Action code (if any)
          },
        ),*/
        duration: duration,
        width: 300.0,
        // Width of the SnackBar
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Inner padding for content
        behavior: SnackBarBehavior.floating, // Floating behavior
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
      ),
    );
  }
}
