import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../lines/repeating_lines.dart';

class FlickeringLinesWidget extends HookWidget {
  final Color lineColor;
  final double strokeWidth;
  final double spacing;
  final bool drawVerticalLines;
  final bool drawHorizontalLines;
  final Duration flickerDuration;

  const FlickeringLinesWidget({
    super.key,
    required this.lineColor,
    required this.strokeWidth,
    required this.spacing,
    this.drawVerticalLines = true,
    this.drawHorizontalLines = true,
    this.flickerDuration = const Duration(milliseconds: 800),
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: flickerDuration);
    final animation =
        useAnimation(Tween(begin: 0.0, end: 0.3).animate(controller));

    useEffect(() {
      controller.repeat(reverse: true);
      return controller.dispose;
    }, [controller]);

    return CustomPaint(
      size: Size.infinite,
      painter: LinePainter(
        lineColor: lineColor,
        strokeWidth: strokeWidth,
        spacing: spacing,
        drawVerticalLines: drawVerticalLines,
        drawHorizontalLines: drawHorizontalLines,
        opacity: animation,
      ),
    );
  }
}
