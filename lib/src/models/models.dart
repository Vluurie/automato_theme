import 'package:flutter/material.dart';

class SvgDimensionConfig {
  final double width;
  final double height;

  const SvgDimensionConfig({
    this.width = 0.0,
    this.height = 0.0,
  });
}

class SvgStyleConfig {
  final String? svgString;
  final Color? color;

  const SvgStyleConfig({
    this.svgString,
    this.color,
  });
}

class BackgroundSvgConfig {
  final Color? svgColor;
  final bool animateInner;
  final bool animateOuter;
  final bool showDual;
  final double? innerMaxWidthPercentage;
  final double? innerScaleExtent;
  final double? outerScaleExtent;
  final String? svgOuterString;
  final String? svgInnerString;

  const BackgroundSvgConfig(
      {this.svgColor,
      required this.animateInner,
      required this.animateOuter,
      required this.showDual,
      this.innerMaxWidthPercentage,
      this.innerScaleExtent,
      this.outerScaleExtent,
      this.svgInnerString,
      this.svgOuterString});
}

class LinesConfig {
  final Color lineColor;
  final double strokeWidth;
  final double spacing;
  final bool drawVerticalLines;
  final bool drawHorizontalLines;
  final bool enableFlicker;
  final Duration flickerDuration;

  const LinesConfig(
      {required this.lineColor,
      required this.strokeWidth,
      required this.spacing,
      required this.flickerDuration,
      required this.enableFlicker,
      required this.drawHorizontalLines,
      required this.drawVerticalLines});
}

class SvgPositionConfig {
  final double top;
  final double bottom;
  final double left;
  final double right;

  const SvgPositionConfig({
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  });
}
