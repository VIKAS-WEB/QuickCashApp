import 'package:flutter/material.dart';
import 'dart:math';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: GaugeWidget(
            label: 'Credit',
            currentAmount: 250.18,
            totalAmount: 1000.0,
          ),
        ),
      ),
    );
  }
}

class GaugeWidget extends StatelessWidget {
  final String label;
  final double currentAmount;
  final double totalAmount;

  const GaugeWidget({
    super.key,
    required this.label,
    required this.currentAmount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the percentage based on the two amounts
    final double percentage = (currentAmount / totalAmount).clamp(0.0, 1.0);

    return Stack(
      alignment: Alignment.center,
      children: [
        // The arc (gauge background)
        CustomPaint(
          size: const Size(250, 250),
          painter: GaugePainter(percentage: percentage),
        ),
        // The arrow
        const Icon(
          Icons.arrow_downward,
          size: 40,
          color: Colors.orange,
        ),
        // The text (Label, amount, and percentage)
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${currentAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${(percentage * 100).toStringAsFixed(1)}%', // Display percentage as text
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  final double percentage;

  GaugePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 60.0;

    final Paint progressPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 60.0;

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      pi, // Start angle (180 degrees)
      pi, // Sweep angle (180 degrees)
      false,
      backgroundPaint,
    );

    // Draw progress arc based on percentage
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
