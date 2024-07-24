import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../../themes/colors/theme_colors.dart';
import '../../themes/dimensions/theme_dimensions.dart';
import '../scalable_vector_graphics/svg_strings/svg_strings.dart';
import '../scalable_vector_graphics/svg_widgets/automato_bg_svg.dart';
import '../scalable_vector_graphics/svg_widgets/automato_border_svg.dart';
import 'overlays/automato_background_border/repeating_border_svg.dart';
import 'overlays/automato_background_lines/automato_background_lines.dart';

class AutomatoBackground extends StatelessWidget {
  final bool showBackgroundSVG;
  final bool showMenuLines;
  final bool showRepeatingBorders;
  final Color? backgroundColor;
  final Color? gradientColor;
  final Color? svgColor;
  final String borderSvg;
  final LinesConfig linesConfig;
  final BackgroundSvgConfig backgroundSvgConfig;
  final SvgPositionConfig backgroundSvgFillPosition;
  final SvgPositionConfig borderSvgFillPositionBottom;
  final SvgPositionConfig borderSvgFillPositionTop;
  final SvgDimensionConfig borderSvgDimension;
  final Widget? child;
  final WidgetRef ref;

  /// Renders a customizable background with optional SVG graphics,
  /// line patterns, and SVG borders for a "Nier" themed application.
  ///
  /// This widget allows for extensive customization, including toggling the visibility
  /// of the main background SVG, line patterns, SVG borders, and specifying
  /// colors for the background, line patterns, and gradient overlay. It also
  /// supports detailed customization of the line drawing properties.
  ///
  /// ## Parameters:
  /// - [showBackgroundSVG]: Controls the visibility of the main background SVG.
  /// - [showMenuLines]: Controls whether line patterns are displayed.
  /// - [showRepeatingBorders]: Determines if repeating SVG borders are shown.
  /// - [backgroundColor]: Optional color override for the background.
  /// - [lineColor]: Separately customizable line color for the lines.
  /// - [gradientColor]: Optional custom color for the gradient overlay.
  /// - [svgColor]: Optional custom color for the svg border, background and pointer.
  /// - [strokeWidth]: Thickness of the lines.
  /// - [spacing]: Spacing between each line.
  /// - [drawVerticalLines]: Whether to draw vertical lines.
  /// - [drawHorizontalLines]: Whether to draw horizontal lines.
  /// - [enableFlicker]: Enables a flickering effect on the lines.
  /// - [flickerDuration]: Duration of the flickering effect.
  ///
  /// ## Example Usage:
  /// ```dart
  // / AutomatoBackground(
  // /   showBackgroundSVG: false,
  // /   showMenuLines: true,
  // /   showRepeatingBorders: false,
  // /   backgroundColor: Colors.deepPurple,
  // /   lineColor: Colors.amber.withOpacity(0.05),
  // /   gradientColor: Colors.red.withOpacity(0.5),
  // /   svgColor: Colors.white
  // /   strokeWidth: 2.0,
  // /   spacing: 6.0,
  // /   drawVerticalLines: true,
  // /   drawHorizontalLines: false,
  // /   enableFlicker: true,
  // /   flickerDuration: Duration(milliseconds: 2000),
  // / )
  /// ```
  ///

  const AutomatoBackground({
    super.key,
    required this.ref,
    this.showBackgroundSVG = true,
    this.showMenuLines = true,
    this.showRepeatingBorders = true,
    this.backgroundColor,
    this.gradientColor,
    this.svgColor,
    this.backgroundSvgConfig = const BackgroundSvgConfig(
        animateInner: true, animateOuter: true, showDual: true),
    this.borderSvg = AutomatoSvgStrings.automatoSvgStrBorder,
    LinesConfig? linesConfig,
    this.borderSvgDimension = const SvgDimensionConfig(
        width: ThemeDimensions.svgWidth, height: ThemeDimensions.borderHeight),
    this.borderSvgFillPositionTop =
        const SvgPositionConfig(top: 20, right: 0, left: 0),
    this.borderSvgFillPositionBottom =
        const SvgPositionConfig(bottom: 20, right: 0, left: 0),
    this.backgroundSvgFillPosition = const SvgPositionConfig(
        top: -500, bottom: -500, left: -250, right: -250),
    this.child,
  }) : linesConfig = linesConfig ??
            const LinesConfig(
              lineColor: Colors.black,
              strokeWidth: 1.0,
              spacing: 6.0,
              flickerDuration: Duration(milliseconds: 800),
              enableFlicker: false,
              drawHorizontalLines: true,
              drawVerticalLines: true,
            );

  @override
  Widget build(BuildContext context) {
    final themeColors = ref.watch(automatoThemeNotifierProvider).colors;
    final bgColor = backgroundColor ?? themeColors['primaryColor']!;
    final linePaintColor = linesConfig.lineColor == Colors.black
        ? themeColors['darkBrown']!
        : linesConfig.lineColor;
    final gradColor = gradientColor?.withOpacity(0.4) ??
        themeColors['gradientStartColor']!.withOpacity(0.05);

    return Scaffold(
      body: Container(
        color: bgColor,
        child: Stack(
          children: [
            if (showBackgroundSVG)
              Positioned.fill(
                top: backgroundSvgFillPosition.top,
                bottom: backgroundSvgFillPosition.bottom,
                left: backgroundSvgFillPosition.left,
                right: backgroundSvgFillPosition.right,
                child: AutomatoBackgroundSVG(
                  svgColor: backgroundSvgConfig.svgColor,
                  showDual: backgroundSvgConfig.showDual,
                  animateInner: backgroundSvgConfig.animateInner,
                  animateOuter: backgroundSvgConfig.animateOuter,
                  svgOuterString: backgroundSvgConfig.svgOuterString ??
                      AutomatoSvgStrings.automatoSvgStrBg,
                  svgInnerString: backgroundSvgConfig.svgInnerString ??
                      AutomatoSvgStrings.automatoSvgStrBgNoLines,
                ),
              ),
            if (showMenuLines)
              Positioned.fill(
                child: AutomatoBackgroundLines(
                  lineColor: linePaintColor,
                  strokeWidth: linesConfig.strokeWidth,
                  spacing: linesConfig.spacing,
                  drawVerticalLines: linesConfig.drawVerticalLines,
                  drawHorizontalLines: linesConfig.drawHorizontalLines,
                  enableFlicker: linesConfig.enableFlicker,
                  flickerDuration: linesConfig.flickerDuration,
                ),
              ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradColor, themeColors['transparentColor']!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            if (showRepeatingBorders)
              Positioned(
                top: borderSvgFillPositionTop.top,
                left: borderSvgFillPositionTop.left,
                right: borderSvgFillPositionTop.right,
                child: buildRepeatingBorderSVG(context,
                    svgWidget: AutomatoBorderSVG(
                      color: svgColor,
                      svgString: borderSvg,
                    ),
                    height: borderSvgDimension.height,
                    width: borderSvgDimension.width),
              ),
            if (showRepeatingBorders)
              Positioned(
                bottom: borderSvgFillPositionBottom.bottom,
                left: borderSvgFillPositionBottom.left,
                right: borderSvgFillPositionBottom.right,
                child: buildRepeatingBorderSVG(context,
                    svgWidget: AutomatoBorderSVG(
                      color: svgColor,
                      svgString: borderSvg,
                    ),
                    height: borderSvgDimension.height,
                    width: borderSvgDimension.width),
              ),
          ],
        ),
      ),
    );
  }
}
