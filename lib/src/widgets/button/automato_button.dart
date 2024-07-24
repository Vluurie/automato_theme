import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../themes/colors/theme_colors.dart';
import '../../themes/dimensions/theme_dimensions.dart';
import '../scalable_vector_graphics/svg_strings/svg_strings.dart';
import '../scalable_vector_graphics/svg_widgets/automato_pointer_svg.dart';
import 'component/automato_button_with_pointer.dart';

class AutomatoButton extends ConsumerWidget {
  final String label;
  final String uniqueId;
  final String svgPointerString;
  final VoidCallback onPressed;
  final Color? startColor;
  final Color? endColor;
  final Color? baseColor;
  final Color? shadowColor;
  final Color? activeFillColor;
  final Color? activeHoverColor;
  final Color? pointerColor;
  final double startBorderWidth;
  final double endBorderWidth;
  final double letterSpacing;
  final double maxScale;
  final String fontFamily;
  final double fontSize;
  final FontWeight startFontWeight;
  final FontWeight endFontWeight;
  final Duration animationDuration;
  final Duration hoverBlinkDuration;
  final bool showPointer;
  final bool stopAnimations;
  final bool stopFillAnimation;
  final bool stopBorderAnimation;
  final bool stopColorAnimation;
  final bool stopTextAnimation;
  final FillBehavior fillBehavior;

  /// A widget that displays a automato themed button with optional pointer SVG and animation controls.
  ///
  /// This widget leverages configurable visual and behavioral settings, allowing for detailed customization of the button's colors, animations, and layout responsiveness. It supports fine-tuning of animation behaviors, enabling a dynamic user interface experience.
  ///
  /// ## Parameters:
  /// - `label`: The text displayed on the button, serving as the button's label.
  /// - `onPressed`: Callback executed when the button is pressed. It should trigger the logic for the button's intended action.
  /// - `showPointer`: Determines whether to display a decorative pointer SVG next to the button.
  /// - `pointerColor`: Specifies the color of the pointer SVG. If not provided, defaults to transparent.
  /// - `startColor`: The color at the start of the gradient effect on the button.
  /// - `endColor`: The color at the end of the gradient effect on the button.
  /// - `baseColor`: The primary background color of the button, used as a fallback when animations are disabled.
  /// - `shadowColor`: Specifies the shadow color beneath the button to enhance its depth and visibility.
  /// - `activeFillColor`: The fill color of the button when in an active state (e.g., hovered or focused).
  /// - `activeHoverColor`: The color of the button when hovered over, enhancing user interaction feedback.
  /// - `startBorderWidth`: The initial border width, allowing for a dynamic change in appearance at the start of an animation.
  /// - `endBorderWidth`: The final border width, permitting adjustments to the button's border at the end of an animation.
  /// - `letterSpacing`: The space between characters in the button's label, enhancing readability.
  /// - `fontFamily`: The font family applied to the button's text, affecting its typographic style.
  /// - `fontSize`: The size of the font for the label, affecting visibility and aesthetic appeal.
  /// - `startFontWeight`: The font weight at the start of the button's animation, defining the initial text boldness.
  /// - `endFontWeight`: The font weight at the end of the button's animation, allowing dynamic adjustment of text boldness.
  /// - `animationDuration`: The duration over which the button's animations occur.
  /// - `hoverBlinkDuration`: The duration of the blink effect when the button is hovered, providing a visual cue to users.
  /// - `maxScale`: The maximum scale factor for responsive scaling, controlling the maximum size relative to its container.
  /// - `stopAnimations`: Globally disables all animations within the button, useful for accessibility and performance considerations.
  /// - `stopBorderAnimation`: Disables animations affecting the border, keeping a consistent border appearance.
  /// - `stopColorAnimation`: Stops the color transition animations, maintaining a consistent color throughout user interaction.
  /// - `stopTextAnimation`: Prevents animations that affect the text, ensuring stability and readability.
  /// - `fillBehavior`: Controls the behavior of the fill animation during active states, specifying how the fill adjusts.
  /// - `stopFillAnimation`: Disables fill animations, maintaining a consistent appearance of the fill.
  /// - `uniqueId`: A unique identifier for the button, ensuring that any state management or animations are properly isolated.
  /// - `svgPointerString`: The SVG string for the pointer of the optional button.
  ///
  /// Example Usage:
  /// ```dart
  /// AutomatoButton(
  ///   label: "Settings",
  ///   onPressed: () {},
  ///   showPointer: true,
  ///   startColor: Colors.blue,
  ///   endColor: Colors.green,
  ///   fillBehavior: FillBehavior.leftToRight,
  /// )
  /// ```

  const AutomatoButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.uniqueId,
    this.showPointer = true,
    this.startColor,
    this.endColor,
    this.baseColor,
    this.shadowColor,
    this.activeFillColor,
    this.activeHoverColor,
    this.pointerColor,
    this.startBorderWidth = 1.0,
    this.endBorderWidth = 4,
    this.fontSize = 22,
    this.fontFamily = 'Arial',
    this.letterSpacing = 0.5,
    this.startFontWeight = FontWeight.normal,
    this.endFontWeight = FontWeight.bold,
    this.animationDuration = const Duration(milliseconds: 300),
    this.hoverBlinkDuration = const Duration(milliseconds: 600),
    this.maxScale = 1.0,
    this.stopAnimations = false,
    this.stopBorderAnimation = false,
    this.stopColorAnimation = false,
    this.stopTextAnimation = false,
    this.fillBehavior = FillBehavior.leftToRight,
    this.stopFillAnimation = false,
    this.svgPointerString = AutomatoSvgStrings.automatoSvgStrPointer,
  })  : assert(fontSize > 0, 'fontSize must be greater than 0'),
        assert(endBorderWidth > startBorderWidth,
            'endBorderWidth must be greater than startBorderWidth');

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
        activeHoverColor ?? AutomatoThemeColors.hoverBrown(ref);

    return ProviderScope(child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final scale = (constraints.maxWidth / 200).clamp(0.0, maxScale);
        final scaledWidth = ThemeDimensions.buttonWidth * scale;
        final scaledHeight = ThemeDimensions.buttonHeight * scale;
        final scaledPointerWidth = ThemeDimensions.pointerSvgWidth * scale;
        final scaledFontSize = fontSize * scale;
        final scaledStartBorderWidth = startBorderWidth * scale;
        final scaledEndBorderWidth = endBorderWidth * scale;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showPointer)
              SizedBox(
                width: scaledPointerWidth,
                child: AutomatoPointerSVG(
                  svgString: svgPointerString,
                  color: pointerColor,
                  width: scaledPointerWidth,
                  uniqueId: uniqueId,
                ),
              ),
            SizedBox(width: 4 * scale),
            SizedBox(
              width: scaledWidth,
              height: scaledHeight,
              child: AutomatoButtonWithPointerProvider(
                controlSvg: showPointer,
                label: label,
                onPressed: onPressed,
                startColor: effectiveStartColor,
                endColor: effectiveEndColor,
                baseColor: effectiveBaseColor,
                shadowColor: effectiveShadowColor,
                activeFillColor: effectiveActiveFillColor,
                activeHoverColor: effectiveActiveHoverColor,
                startBorderWidth: scaledStartBorderWidth,
                endBorderWidth: scaledEndBorderWidth,
                fontSize: scaledFontSize,
                fontFamily: fontFamily,
                letterSpacing: letterSpacing,
                startFontWeight: startFontWeight,
                endFontWeight: endFontWeight,
                animationDuration: animationDuration,
                hoverBlinkDuration: hoverBlinkDuration,
                stopAnimations: stopAnimations,
                stopBorderAnimation: stopBorderAnimation,
                stopColorAnimation: stopColorAnimation,
                stopTextAnimation: stopTextAnimation,
                stopFillAnimation: stopFillAnimation,
                fillBehavior: fillBehavior,
                uniqueId: uniqueId,
              ),
            ),
          ],
        );
      },
    ));
  }
}
