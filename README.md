# Automato Theme

An theme inspired by the Nier: Automata game writen in Flutter Dart.
Developed for windows sized applications, not for mobile since it got not responsive dialogs.

# Features

For a live preview, you can check out: https://automato-theme-example.netlify.app/

# Featuring:

Easy-to-use widgets
Futuristic and customizable themes
Background animations and effects

# Getting Started
To start using the Automato Theme package, add it to your pubspec.yaml:

```yaml
dependencies:
  automato_theme:
    git:
      url: https://github.com/Vluurie/automato_theme.git
      ref: main 
  flutter_riverpod: latest_version
  ```
# Usage

Setting Up Dynamic Theme Switching with Riverpod
First, set up your main application to use the Automato Theme:

```dart
import 'package:automato_theme/automato_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeNotifier = await AutomatoThemeNotifier.loadFromPreferences();
  runApp(
    ProviderScope(
      overrides: [
        automatoThemeNotifierProvider.overrideWith((ref) => themeNotifier),
      ],
      child: const AutomatoThemeExample(),
    ),
  );
}

class AutomatoThemeExample extends ConsumerWidget {
  const AutomatoThemeExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(automatoThemeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automato Theme Example',
      theme: themeState.theme,
      home: const AutomatoThemeHomePage(),
    );
  }
}
```


# Automato Widgets

## AutomatoBackground


```dart
  /// Renders a customizable background with optional SVG graphics,
  /// line patterns, and SVG borders for a "Nier" themed application.
  ///
  /// This widget allows for extensive customization, including toggling the visibility
  /// of the main background SVG, line patterns, SVG borders, and specifying
  /// colors for the background, line patterns, and gradient overlay. It also
  /// supports detailed customization of the line drawing properties.
  ///
  /// ## Parameters:
  <!-- AutomatoBackground AutomatoBackground({
  Key? key,
  required WidgetRef ref,
  bool showBackgroundSVG = true,
  bool showMenuLines = true,
  bool showRepeatingBorders = true,
  Color? backgroundColor,
  Color? gradientColor,
  Color? svgColor,
  BackgroundSvgConfig backgroundSvgConfig = const BackgroundSvgConfig(animateInner: true, animateOuter: true, showDual: true),
  String borderSvg = AutomatoSvgStrings.automatoSvgStrBorder,
  LinesConfig? linesConfig,
  SvgDimensionConfig borderSvgDimension = const SvgDimensionConfig(width: ThemeDimensions.svgWidth, height: ThemeDimensions.borderHeight),
  SvgPositionConfig borderSvgFillPositionTop = const SvgPositionConfig(top: 20, right: 0, left: 0),
  SvgPositionConfig borderSvgFillPositionBottom = const SvgPositionConfig(bottom: 20, right: 0, left: 0),
  SvgPositionConfig backgroundSvgFillPosition = const SvgPositionConfig(top: -500, bottom: -500, left: -250, right: -250),
  Widget? child,
}) -->

// usage

AutomatoBackground(
  ref: ref,
  showBackgroundSVG: true,
  showMenuLines: true,
  showRepeatingBorders: true,
  gradientColor: AutomatoThemeColors.gradientStartColor(ref),
  linesConfig: LinesConfig(
    lineColor: AutomatoThemeColors.darkBrown(ref),
    strokeWidth: 2,
    spacing: 5,
    flickerDuration: const Duration(milliseconds: 5000),
    enableFlicker: true,
    drawHorizontalLines: true,
    drawVerticalLines: true,
  ),
)
```

## AutomatoCheckBox

```dart
/// A customizable checkbox widget that integrates with the Automato theme
/// and uses Riverpod for state management.
///
/// This widget provides a checkbox with extensive customization options,
/// including colors for checked, unchecked, and disabled states, border radius,
/// padding, text styles, and box shadows. It is designed to work seamlessly
/// with the Automato theme and Riverpod state management.
///
/// ## Parameters:
/// - [initialValue]: The initial value of the checkbox.
/// - [onChanged]: A callback that is called when the value of the checkbox changes.
/// - [text]: The text label displayed next to the checkbox.
/// - [fillColorChecked]: The fill color of the checkbox when it is checked.
/// - [fillColorUnchecked]: The fill color of the checkbox when it is unchecked.
/// - [fillColorDisabled]: The fill color of the checkbox when it is disabled.
/// - [textColorChecked]: The text color when the checkbox is checked.
/// - [textColorUnchecked]: The text color when the checkbox is unchecked.
/// - [borderRadius]: The border radius of the checkbox.
/// - [padding]: The padding around the checkbox.
/// - [textStyle]: The text style of the label.
/// - [boxShadow]: The box shadow of the checkbox container.
///
AutomatoCheckBox(
  textColorChecked: AutomatoThemeColors.primaryColor(ref),
  textColorUnchecked: AutomatoThemeColors.primaryColor(ref),
  initialValue: isChecked,
  text: isChecked ? 'Switch to Default Theme' : 'Switch to Futuristic Theme',
  onChanged: (bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
    if (isChecked) {
      ref.read(automatoThemeNotifierProvider.notifier).switchToFuturisticTheme();
    } else {
      ref.read(automatoThemeNotifierProvider.notifier).switchToDefaultTheme();
    }
  },
)
```

## AutomatoButton

```dart

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

AutomatoButton(
  activeFillColor: AutomatoThemeColors.saveZone(ref),
  startColor: AutomatoThemeColors.primaryColor(ref),
  baseColor: AutomatoThemeColors.darkBrown(ref),
  label: 'Show Dialog',
  uniqueId: 'dialog_button',
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) => AutomatoDialog(
        title: 'Automato Dialog',
        content: Text(
          'This is a custom dialog using Automato Theme.',
          style: TextStyle(
            fontSize: 24,
            color: AutomatoThemeColors.textDialogColor(ref)
          ),
        ),
        onYesPressed: () => Navigator.of(context).pop(),
        onNoPressed: () => Navigator.of(context).pop(),
      ),
    );
  },
)
```


## AutomatoLoading


```dart

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

SizedBox(
  width: 100,
  height: 100,
  child: AutomatoLoading(
    color: AutomatoThemeColors.darkBrown(ref),
    translateX: 100,
    svgString: AutomatoSvgStrings.automatoSvgStrHead,
  ),
)
```

## Dynamic Theme Switching

To dynamically switch themes, use the AutomatoThemeNotifier with Riverpod.

Switching to Futuristic Theme

```dart
ref.read(automatoThemeNotifierProvider.notifier).switchToFuturisticTheme();
```

Switching to Default Theme

```dart
ref.read(automatoThemeNotifierProvider.notifier).switchToDefaultTheme();
```
