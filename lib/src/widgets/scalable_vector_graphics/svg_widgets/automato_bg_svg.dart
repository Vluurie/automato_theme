import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AutomatoBackgroundSVG extends StatefulWidget {
  /// The color to apply to the SVG(s). If null, the SVGs will render in their intrinsic colors.
  final Color? svgColor;

  /// Determines whether the inner SVG layer should perform scale animations.
  final bool animateInner;

  /// Determines whether the outer SVG layer should perform scale animations.
  final bool animateOuter;

  /// When true, displays both inner and outer SVG layers for a dual-layer effect.
  final bool showDual;

  /// Sets the maximum width of the inner SVG relative to its parent's width. Defaults to 95%.
  final double? innerMaxWidthPercentage;

  /// Duration of the animation cycle for the inner SVG layer.
  final Duration innerAnimationDuration;

  /// Duration of the animation cycle for the outer SVG layer.
  final Duration outerAnimationDuration;

  /// Starting scale factor for the inner SVG animation. The animation oscillates around this value.
  final double innerScaleExtent;

  /// Starting scale factor for the outer SVG animation, around which the animation oscillates.
  final double outerScaleExtent;

  /// The outer background SVG string to be displayed in the background.
  final String svgOuterString;

  /// The inner background SVG string to be displayed in the background.
  final String svgInnerString;

  /// The `AutomatoBackgroundSVG` widget displays a scalable vector graphic (SVG) as a background with optional animations
  /// and the ability to render in dual-layer mode for added visual depth.
  ///
  /// When used, this widget allows for the dynamic scaling of one or two SVGs, with support for color customization,
  /// animated scaling, and adaptive sizing according to the constraints of its parent container. This widget is
  /// ideal for creating visually engaging backgrounds that are responsive to user interactions or environmental
  /// changes within the application.
  ///
  /// Parameters:
  ///  - `svgColor`: Defines the color overlay for the SVG graphics. Leaving this null will render SVGs in their native colors.
  ///  - `animateInner`: Controls whether the inner SVG graphics should be subject to animation. When set to true, the inner graphic will gently scale up and down.
  ///  - `animateOuter`: Similar to `animateInner`, but affects the outer layer of SVG graphics, if `showDual` is set to true.
  ///  - `showDual`: A boolean flag indicating whether a second, outer SVG graphic should be rendered behind the primary (inner) graphic.
  ///  - `innerMaxWidthPercentage`: Determines the maximum width of the inner SVG, as a percentage of its parent's width.
  ///  - `innerAnimationDuration`: The duration over which the inner SVG scale animation should cycle.
  ///  - `outerAnimationDuration`: The duration of the scaling animation for the outer SVG graphic.
  ///  - `innerScaleExtent`: The initial scaling factor of the inner SVG; during animation, the scale will oscillate around this value.
  ///  - `outerScaleExtent`: The base scaling factor for the outer SVG, around which the scale animation will oscillate, if enabled.
  ///  - `svgOuterString`:The outer string for the SVG. Sets any provided scalable vector graphic as an background.
  ///  - `svgInnerString`:The inner string for the SVG. Sets any provided scalable vector graphic as an background.

  const AutomatoBackgroundSVG(
      {super.key,
      this.svgColor,
      this.animateInner = false,
      this.animateOuter = false,
      this.showDual = false,
      this.innerMaxWidthPercentage = 10.0,
      this.innerAnimationDuration = const Duration(seconds: 3),
      this.outerAnimationDuration = const Duration(seconds: 2),
      this.innerScaleExtent = 1.0,
      this.outerScaleExtent = 0.97,
      required this.svgOuterString,
      required this.svgInnerString});

  @override
  State<AutomatoBackgroundSVG> createState() => _AutomatoBackgroundSVGState();
}

class _AutomatoBackgroundSVGState extends State<AutomatoBackgroundSVG>
    with TickerProviderStateMixin {
  late AnimationController _controllerInner;
  late AnimationController _controllerOuter;
  late Animation<double> _scaleAnimationInner;
  late Animation<double> _scaleAnimationOuter;

  @override
  void initState() {
    super.initState();
    // Initialize animation controllers for inner and outer SVGs
    _controllerInner = AnimationController(
      duration: widget.innerAnimationDuration,
      vsync: this,
    );
    _controllerOuter = AnimationController(
      duration: widget.outerAnimationDuration,
      vsync: this,
    );

    setupAnimations();
  }

  void setupAnimations() {
    // Setup scale animation for the inner SVG layer
    _scaleAnimationInner = Tween<double>(
      begin: widget.innerScaleExtent,
      end: widget.innerScaleExtent * 0.97,
    ).animate(
      CurvedAnimation(parent: _controllerInner, curve: Curves.easeInOut),
    )..addListener(() => setState(() {}));

    // Setup scale animation for the outer SVG layer
    _scaleAnimationOuter = Tween<double>(
      begin: widget.outerScaleExtent,
      end: widget.outerScaleExtent * 1.03,
    ).animate(
      CurvedAnimation(parent: _controllerOuter, curve: Curves.easeInOut),
    )..addListener(() => setState(() {}));

    // Conditionally start the animations based on widget properties
    if (widget.animateInner) {
      _controllerInner.repeat(reverse: true);
    }
    if (widget.animateOuter) {
      _controllerOuter.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controllerInner.dispose();
    _controllerOuter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double innerMaxWidth =
            maxWidth * (widget.innerMaxWidthPercentage ?? 0.95);
        double outerMaxWidth = maxWidth;

        // Helper method to create SVG image widget with scaling animation
        Widget svgImage(String svgData, double maxWidth, double maxHeight,
            Animation<double> scaleAnim) {
          return Center(
            child: Transform.scale(
              scale: scaleAnim.value,
              child: SvgPicture.string(
                svgData,
                width: maxWidth,
                height: maxHeight,
                color: widget.svgColor,
              ),
            ),
          );
        }

        // Layering logic for single or dual SVG display with associated scale animations
        return Stack(
          alignment: Alignment.center,
          children: [
            if (widget.showDual)
              svgImage(widget.svgOuterString, outerMaxWidth, outerMaxWidth,
                  _scaleAnimationOuter),
            svgImage(widget.svgInnerString, innerMaxWidth, innerMaxWidth,
                _scaleAnimationInner),
          ],
        );
      },
    );
  }
}
