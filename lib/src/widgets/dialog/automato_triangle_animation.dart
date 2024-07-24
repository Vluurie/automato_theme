import 'dart:math';
import 'package:automato_theme/automato_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that animates a reveal effect using triangles.
///
/// The `TriangleRevealAnimation` widget animates a series of triangles
/// that gradually reveal a target area. It uses a custom painter to draw
/// the triangles and an animation controller to manage the reveal effect.
///
/// ## Parameters:
/// - [controller]: An animation controller that drives the reveal animation.
/// - [ref]: A reference to the Riverpod provider for theme and state management.
///
/// The widget leverages a `CustomPainter` to draw triangles at random positions
/// on the canvas. The opacity of each triangle is controlled by the animation
/// value, creating a fading effect as the animation progresses.
///
/// ## Example Usage:
/// ```dart
/// TriangleRevealAnimation(
///   controller: AnimationController(
///     vsync: this,
///     duration: const Duration(seconds: 2),
///   ),
///   ref: ref,
/// )
/// ```
class TriangleRevealAnimation extends StatefulWidget {
  final Animation<double> controller;
  final WidgetRef ref;

  const TriangleRevealAnimation({
    super.key,
    required this.controller,
    required this.ref,
  });

  @override
  TriangleRevealAnimationState createState() => TriangleRevealAnimationState();
}

class TriangleRevealAnimationState extends State<TriangleRevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _triangleController;
  final int numberOfTriangles = 12;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _triangleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
  }

  @override
  void dispose() {
    _triangleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TrianglePainter(
        animation: widget.controller,
        context: context,
        ref: widget.ref,
        numberOfTriangles: numberOfTriangles,
        random: random,
      ),
      child: Container(),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Animation<double> animation;
  final BuildContext context;
  final WidgetRef ref;
  final int numberOfTriangles;
  final Random random;
  final Paint trianglePaint;

  TrianglePainter({
    required this.animation,
    required this.context,
    required this.ref,
    required this.numberOfTriangles,
    required this.random,
  })  : trianglePaint = Paint()..color = AutomatoThemeColors.darkBrown(ref),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < numberOfTriangles; i++) {
      final double opacity =
          (random.nextDouble() * (1 - animation.value)).clamp(0.0, 1.0);
      final Paint paint = trianglePaint
        ..color = trianglePaint.color.withOpacity(opacity);
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;
      const double triangleSize = 120.0;

      final path = Path()
        ..moveTo(x, y)
        ..lineTo(x + triangleSize, y)
        ..lineTo(x + triangleSize / 2, y + triangleSize)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
