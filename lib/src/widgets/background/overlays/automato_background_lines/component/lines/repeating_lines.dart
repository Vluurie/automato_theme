import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;
  final double spacing;
  final bool drawVerticalLines;
  final bool drawHorizontalLines;
  final double opacity;

  LinePainter({
    required this.lineColor,
    required this.strokeWidth,
    required this.spacing,
    this.drawVerticalLines = true,
    this.drawHorizontalLines = true,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = lineColor.withOpacity(opacity)
      ..strokeWidth = strokeWidth;

    if (drawVerticalLines) {
      for (double i = 0; i < size.width; i += spacing) {
        canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
      }
    }

    if (drawHorizontalLines) {
      for (double i = 0; i < size.height; i += spacing) {
        canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return oldDelegate.opacity != opacity; // Repaint only when opacity changes
  }
}
