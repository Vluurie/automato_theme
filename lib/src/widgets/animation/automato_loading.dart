import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that displays a loading animation using an SVG image.
///
/// The `AutomatoLoading` widget provides a loading animation that combines
/// translation and rotation effects on an SVG image. The animation can be
/// customized with various parameters such as duration, translation distance,
/// rotation angle, size, and color.
///
/// ## Parameters:
/// - [svgString]: The SVG string data for the image to be displayed.
/// - [duration]: The duration of the animation cycle. Default is 2 seconds.
/// - [translateX]: The maximum translation distance along the x-axis. Default is 50.0.
/// - [rotationMaxAngle]: The maximum rotation angle in radians. Default is 2π (360 degrees).
/// - [size]: The size of the widget. Default is 200.0.
/// - [color]: The color of the SVG image. Default is black.
///
/// ## Example Usage:
/// ```dart
/// AutomatoLoading(
///   svgString: '<svg>...</svg>',
///   duration: Duration(seconds: 2),
///   translateX: 50.0,
///   rotationMaxAngle: 2 * 3.1415927,
///   size: 100.0,
///   color: Colors.blue,
/// )
/// ```
class AutomatoLoading extends StatefulWidget {
  final String svgString;
  final Duration duration;
  final double translateX;
  final double rotationMaxAngle;
  final double size;
  final Color color;

  const AutomatoLoading({
    super.key,
    required this.svgString,
    this.duration = const Duration(seconds: 2),
    this.translateX = 50.0,
    this.rotationMaxAngle = 2 * 3.1415927,
    this.size = 200.0,
    this.color = Colors.black,
  });

  @override
  AutomatoLoadingState createState() => AutomatoLoadingState();
}

class AutomatoLoadingState extends State<AutomatoLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * widget.rotationMaxAngle;
          final dx = (_controller.value - 0.5) * 2 * widget.translateX;

          return Transform.translate(
            offset: Offset(dx, 0),
            child: Transform.rotate(
              angle: angle,
              child: child,
            ),
          );
        },
        child: SvgPicture.string(
          widget.svgString,
          color: widget.color,
        ),
      ),
    );
  }
}
