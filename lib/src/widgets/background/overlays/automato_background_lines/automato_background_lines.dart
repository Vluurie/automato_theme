import 'package:flutter/material.dart';

import 'component/animation/flicker_animation.dart';
import 'component/lines/repeating_lines.dart';

class AutomatoBackgroundLines extends StatelessWidget {
  final Color lineColor;
  final double strokeWidth;
  final double spacing;
  final bool drawVerticalLines;
  final bool drawHorizontalLines;
  final bool enableFlicker;
  final Duration flickerDuration;

  const AutomatoBackgroundLines(
      {super.key,
      required this.lineColor,
      required this.strokeWidth,
      required this.spacing,
      this.drawVerticalLines = true,
      this.drawHorizontalLines = true,
      this.enableFlicker = false,
      this.flickerDuration = const Duration(milliseconds: 800)});

  @override
  Widget build(BuildContext context) {
    return enableFlicker
        ? FlickeringLinesWidget(
            lineColor: lineColor,
            strokeWidth: strokeWidth,
            spacing: spacing,
            drawVerticalLines: drawVerticalLines,
            drawHorizontalLines: drawHorizontalLines,
            flickerDuration: flickerDuration,
          )
        : CustomPaint(
            size: Size.infinite,
            painter: LinePainter(
              lineColor: lineColor,
              strokeWidth: strokeWidth,
              spacing: spacing,
              drawVerticalLines: drawVerticalLines,
              drawHorizontalLines: drawHorizontalLines,
              opacity: 0.1,
            ),
          );
  }
}
