/*
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: GaugeList(),
        ),
      ),
    );
  }
}

class GaugeList extends StatelessWidget {
  const GaugeList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            GaugeContainer(
              child: GaugeWidget(
                label: 'Credit',
                currentAmount: 250.18,
                totalAmount: 1000.0,
                color: Colors.green,
                icon: Icons.credit_card,
              ),
            ),
            SizedBox(width: 16),
            GaugeContainer(
              child: GaugeWidget(
                label: 'Debit',
                currentAmount: 400.75,
                totalAmount: 1000.0,
                color: Colors.red,
                icon: Icons.remove_circle,
              ),
            ),
            SizedBox(width: 16),
            GaugeContainer(
              child: GaugeWidget(
                label: 'Invest',
                currentAmount: 700.0,
                totalAmount: 1000.0,
                color: Colors.purple,
                icon: Icons.trending_up,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GaugeContainer extends StatelessWidget {
  final Widget child;

  const GaugeContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: child,
    );
  }
}

class GaugeWidget extends StatelessWidget {
  final String label;
  final double currentAmount;
  final double totalAmount;
  final Color color;
  final IconData icon;

  const GaugeWidget({
    super.key,
    required this.label,
    required this.currentAmount,
    required this.totalAmount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (currentAmount / totalAmount).clamp(0.0, 1.0);

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(100, 120),
          painter: GaugePainter(percentage: percentage, color: color),
        ),
        // Centered Column with Icon on top and Text below
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            */
/*Icon(
              icon,
              size: 30, // Icon size
              color: color,
            ),*//*

            const SizedBox(height: 10), // Space between icon and text
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${currentAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  final double percentage;
  final Color color;

  GaugePainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0;

    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0;

    // Draw the background arc (representing the full gauge)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      pi, // Start angle (180 degrees)
      pi, // Sweep angle (180 degrees)
      false,
      backgroundPaint,
    );

    // Draw the progress arc (representing the percentage filled)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      pi, // Start angle
      pi * percentage, // Sweep angle based on percentage
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
*/
