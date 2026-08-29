import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircleChart extends StatelessWidget {
  final int available;
  final int borrowed;
  final int returned;
  final int overdue;

  const CircleChart({
    super.key,
    required this.available,
    required this.borrowed,
    required this.returned,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    final total = available + borrowed + returned + overdue;
    if (total == 0) {
      return const SizedBox(
        width: 160,
        height: 160,
        child: Center(
          child: Text(
            "No borrowing\nactivity",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: 160,
      height: 160,
      child: CustomPaint(
        painter: DonutPainter(
          available: available,
          borrowed: borrowed,
          returned: returned,
          overdue: overdue,
        ),
      ),
    );
  }
}

class DonutPainter extends CustomPainter {
  final int available;
  final int borrowed;
  final int returned;
  final int overdue;

  DonutPainter({
    required this.available,
    required this.borrowed,
    required this.returned,
    required this.overdue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final total = available + borrowed + returned + overdue;
    if (total == 0) {
      return;
    }
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 56.0;
    const thickness = 27.0;
    final circle = Rect.fromCircle(center: center, radius: radius);

    final availablePaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;
    final borrowedPaint = Paint()
      ..color = const Color(0xFFFF1F25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;
    final returnedPaint = Paint()
      ..color = const Color(0xFF2196F3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;
    final overduePaint = Paint()
      ..color = const Color(0xFFFF9800)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    const startAngle = -math.pi / 2;
    final availableAngle = available / total * 2 * math.pi;
    final borrowedAngle = borrowed / total * 2 * math.pi;
    final returnedAngle = returned / total * 2 * math.pi;
    final overdueAngle = overdue / total * 2 * math.pi;

    double currentAngle = startAngle;
    canvas.drawArc(circle, currentAngle, availableAngle, false, availablePaint);
    currentAngle += availableAngle;
    canvas.drawArc(circle, currentAngle, borrowedAngle, false, borrowedPaint);
    currentAngle += borrowedAngle;
    canvas.drawArc(circle, currentAngle, returnedAngle, false, returnedPaint);
    currentAngle += returnedAngle;
    canvas.drawArc(circle, currentAngle, overdueAngle, false, overduePaint);
  }

  @override
  bool shouldRepaint(covariant DonutPainter oldPainter) {
    return oldPainter.available != available ||
        oldPainter.borrowed != borrowed ||
        oldPainter.returned != returned ||
        oldPainter.overdue != overdue;
  }
}
