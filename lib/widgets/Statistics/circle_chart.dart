import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircleChart extends StatelessWidget {
  final int available;
  final int borrowed;

  const CircleChart({
    super.key,
    required this.available,
    required this.borrowed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: CustomPaint(
        painter: DonutPainter(available: available, borrowed: borrowed),
      ),
    );
  }
}

class DonutPainter extends CustomPainter {
  final int available;
  final int borrowed;

  DonutPainter({required this.available, required this.borrowed});

  @override
  void paint(Canvas canvas, Size size) {
    final total = available + borrowed;
    if (total == 0) {
      return;
    }

    final center = Offset(size.width / 2, size.height / 2);
    const radius = 56.0;
    const thickness = 27.0;
    final circle = Rect.fromCircle(center: center, radius: radius);

    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final redPaint = Paint()
      ..color = const Color(0xFFFF1F25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final greenAngle = available / total * 2 * math.pi;
    final redAngle = borrowed / total * 2 * math.pi;

    const startAngle = -math.pi / 2;

    canvas.drawArc(circle, startAngle, greenAngle, false, greenPaint);
    canvas.drawArc(circle, startAngle + greenAngle, redAngle, false, redPaint);
  }

  @override
  bool shouldRepaint(covariant DonutPainter oldPainter) {
    return oldPainter.available != available || oldPainter.borrowed != borrowed;
  }
}
