import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AutomatoBorderSVG extends StatelessWidget {
  final String svgString;

  /// A color to apply to the SVG drawing.
  final Color? color;

  /// [AutomatoBorderSVG] is a [StatelessWidget] responsible for rendering
  /// a decorative SVG border. This widget uses an inline SVG string to
  /// create a specific decorative pattern that can be used as a border
  /// in a Flutter application.
  ///
  /// The `svgString` parameter can be used to dynamically change the SVG.
  ///
  /// The `color` parameter can be used to dynamically change the color of
  /// the SVG to better fit the theme or design where this SVG is used.
  ///
  /// ## Usage Example:
  /// ```dart
  /// Center(
  ///   child: AutomatoBorderSVG(color: Colors.blue),
  /// )
  /// ```
  /// This places the BorderSVG in the center of its parent with a blue color.
  ///
  /// For a repeating pattern, consider employing a `ListView`,
  /// `Stack`, or custom `Painter` that repeats the SVG horizontally or vertically.

  const AutomatoBorderSVG({super.key, required this.svgString, this.color});

  @override
  Widget build(BuildContext context) {
    String svgStr = svgString;

    return Center(
      child: SvgPicture.string(svgStr,
          width: 64.932,
          height: 15.759,
          color: color,
          colorBlendMode: color != null ? BlendMode.srcIn : BlendMode.dst),
    );
  }
}
