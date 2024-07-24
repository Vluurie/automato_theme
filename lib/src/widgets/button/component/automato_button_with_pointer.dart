import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state_managment/provider/automato_provider.dart';
import '../../../themes/colors/theme_colors.dart';

enum FillBehavior { leftToRight, filledRightToLeft, filled, none }

class AutomatoButtonWithPointerProvider extends HookConsumerWidget {
  final String label;
  final VoidCallback onPressed;
  final bool controlSvg;
  final Color? startColor;
  final Color? endColor;
  final Color? baseColor;
  final Color? shadowColor;
  final Color? activeFillColor;
  final Color? activeHoverColor;
  final double startBorderWidth;
  final double endBorderWidth;
  final double letterSpacing;
  final String fontFamily;
  final double fontSize;
  final FontWeight startFontWeight;
  final FontWeight endFontWeight;
  final Duration animationDuration;
  final Duration hoverBlinkDuration;
  final bool stopAnimations;
  final bool stopBorderAnimation;
  final bool stopColorAnimation;
  final bool stopTextAnimation;
  final bool stopFillAnimation;
  final FillBehavior fillBehavior;
  final String uniqueId;

  const AutomatoButtonWithPointerProvider({
    super.key,
    required this.label,
    required this.onPressed,
    required this.uniqueId,
    this.controlSvg = false,
    this.startColor,
    this.endColor,
    this.baseColor,
    this.shadowColor,
    this.activeFillColor,
    this.activeHoverColor,
    this.startBorderWidth = 1.0,
    this.endBorderWidth = 2.5,
    this.fontFamily = 'Arial',
    this.fontSize = 21,
    this.letterSpacing = 0.5,
    this.startFontWeight = FontWeight.normal,
    this.endFontWeight = FontWeight.bold,
    this.animationDuration = const Duration(milliseconds: 250),
    this.hoverBlinkDuration = const Duration(milliseconds: 600),
    this.stopAnimations = false,
    this.stopBorderAnimation = false,
    this.stopColorAnimation = false,
    this.stopTextAnimation = false,
    this.stopFillAnimation = false,
    this.fillBehavior = FillBehavior.leftToRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Assign runtime values for colors
    final effectiveStartColor =
        startColor ?? AutomatoThemeColors.darkBrown(ref);
    final effectiveEndColor = endColor ?? AutomatoThemeColors.tan(ref);
    final effectiveBaseColor = baseColor ?? AutomatoThemeColors.brown025(ref);
    final effectiveShadowColor =
        shadowColor ?? AutomatoThemeColors.brown25(ref);
    final effectiveActiveFillColor =
        activeFillColor ?? AutomatoThemeColors.brown(ref);
    final effectiveActiveHoverColor =
        activeHoverColor ?? AutomatoThemeColors.darkBrown(ref);

    // Animation controller for the main button animations.
    final AnimationController animationController =
        useAnimationController(duration: animationDuration);

    // Animation that smooths the transition of values using an ease-out curve.
    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    // Controller for handling hover state animations with customization.
    final AnimationController hoverController = useAnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        animationBehavior: AnimationBehavior.preserve);

    // Color animation for the hover effect transitioning between active fill colors.
    final Animation<Color?> hoverColorAnimation = ColorTween(
      begin: effectiveActiveFillColor,
      end: effectiveActiveHoverColor,
    ).animate(hoverController);

    // LayoutBuilder to adapt the button based on the parent container's width.
    return LayoutBuilder(builder: (context, constraints) {
      final scale =
          constraints.maxWidth / 360; // Scaling factor based on width.
      final scaledFontSize =
          fontSize * scale; // Adjust font size based on scale.
      final scaledStartBorderWidth =
          startBorderWidth * scale; // Start border width adjusted for scale.
      final scaledEndBorderWidth =
          endBorderWidth * scale; // End border width adjusted for scale.

      // InkWell widget to handle tap and hover interactions.
      return InkWell(
        onTap: onPressed, // Trigger onPressed when tapped.
        onHover: (value) {
          if (!stopAnimations) {
            // Check if animations are not stopped globally.
            if (value) {
              ref.read(svgVisibilityProvider(uniqueId).notifier).state = value;
              hoverController.repeat(reverse: true, period: hoverBlinkDuration);
            } else {
              ref.read(svgVisibilityProvider(uniqueId).notifier).state = value;
              hoverController.stop();
              hoverController.reset();
            }
            value
                ? animationController.forward()
                : animationController.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([
            curvedAnimation,
            hoverColorAnimation
          ]), // Merge animations for collective updates.
          builder: (context, child) {
            // Dynamic color assignment based on animation state.
            final color = stopColorAnimation
                ? effectiveStartColor
                : ColorTween(begin: effectiveStartColor, end: effectiveEndColor)
                    .evaluate(curvedAnimation)!;
            final borderColor = stopBorderAnimation
                ? effectiveBaseColor
                : ColorTween(begin: effectiveBaseColor, end: effectiveEndColor)
                    .evaluate(curvedAnimation)!;
            final borderWidth = stopBorderAnimation
                ? scaledStartBorderWidth
                : Tween<double>(
                        begin: scaledStartBorderWidth,
                        end: scaledEndBorderWidth)
                    .evaluate(curvedAnimation);
            final fillColor =
                hoverColorAnimation.value ?? effectiveActiveFillColor;

            double widthFactor =
                curvedAnimation.value; // Factor for fill animation.
            Alignment alignment = Alignment.centerLeft; // Default alignment.

            // Adjust alignment and width factor based on fill behavior.
            switch (fillBehavior) {
              case FillBehavior.filledRightToLeft:
                widthFactor = 1.0 - curvedAnimation.value;
                alignment = Alignment.centerRight;
                break;
              case FillBehavior.filled:
                widthFactor = 1.0;
                break;
              case FillBehavior.none:
                widthFactor = 0.0;
                break;
              case FillBehavior.leftToRight:
                break;
            }

            // Main container holding the button's visual elements.
            return Container(
              decoration: BoxDecoration(
                color: effectiveBaseColor,
                boxShadow: [
                  if (curvedAnimation.value < 1)
                    BoxShadow(color: effectiveShadowColor)
                ],
              ),
              child: Stack(
                children: [
                  // Conditional fill animation layer.
                  if (!stopFillAnimation)
                    ClipRect(
                      child: Align(
                        alignment: alignment,
                        widthFactor: widthFactor,
                        child: Container(color: fillColor),
                      ),
                    ),
                  // Border layer positioned to fit within the container.
                  Positioned.fill(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: 3 * scale, bottom: 3 * scale),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: borderColor, width: borderWidth),
                          bottom: BorderSide(
                              color: borderColor, width: borderWidth),
                        ),
                      ),
                    ),
                  ),
                  // Text and icon alignment within the button.
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0 * scale),
                      child: IntrinsicWidth(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1.0),
                              child: Container(
                                width: 18 * scale,
                                height: 18 * scale,
                                color: color,
                              ),
                            ),
                            SizedBox(width: 8 * scale),
                            Text(
                              label,
                              style: TextStyle(
                                color: color,
                                fontFamily: fontFamily,
                                letterSpacing: letterSpacing,
                                fontSize: scaledFontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
