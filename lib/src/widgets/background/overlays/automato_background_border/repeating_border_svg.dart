import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Renders a repeating pattern of the provided [svgWidget] across the screen width.
///
/// Parameters:
///   - [context]: The build context.
///   - [svgWidget]: The SVG widget to repeat. Can be any widget.
///   - [height]: The height of the pattern area.
///   - [width]: The width of the pattern area.
///   - [mirror]: A boolean to determine whether to mirror the SVG upside down.
///
/// Returns a horizontally scrollable area that simulates a repeating pattern effect.
Widget buildRepeatingBorderSVG(BuildContext context,
    {required Widget svgWidget,
    required double height,
    required double width,
    bool mirror = false}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final numSVGs = (screenWidth / width).ceil();

  return SizedBox(
    height: height,
    child: ListView.builder(
      itemCount: numSVGs,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => SizedBox(
        width: width,
        child: mirror
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(math.pi),
                child: svgWidget,
              )
            : svgWidget,
      ),
    ),
  );
}
