import 'package:flutter/material.dart';
import 'package:automato_theme/automato_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A customizable dialog widget that integrates with the Automato theme
/// and uses Riverpod for state management.
///
/// This widget provides a dialog with extensive customization options,
/// including colors for the background, title, buttons, and text styles.
/// It also supports adding a gradient, custom background, and animations.
///
/// ## Parameters:
/// - [title]: The title of the dialog.
/// - [content]: The content widget of the dialog.
/// - [onYesPressed]: The callback that is called when the yes button is pressed.
/// - [onNoPressed]: The callback that is called when the no button is pressed.
/// - [yesLabel]: The label of the yes button. Default is 'Yes'.
/// - [noLabel]: The label of the no button. Default is 'No'.
/// - [backgroundColor]: Optional background color for the dialog.
/// - [titleColor]: Optional color for the title text.
/// - [yesButtonColor]: Optional background color for the yes button.
/// - [noButtonColor]: Optional background color for the no button.
/// - [startColor]: Optional start color for the gradient.
/// - [activeHoverColorYes]: Optional hover color for the yes button.
/// - [activeHoverColorNo]: Optional hover color for the no button.
/// - [showYesPointer]: Whether to show a pointer on the yes button. Default is true.
/// - [showNoPointer]: Whether to show a pointer on the no button. Default is true.
/// - [maxWidth]: The maximum width of the dialog. Default is 800.
/// - [borderRadius]: The border radius of the dialog. Default is 20.0.
/// - [elevation]: The elevation of the dialog. Default is 10.0.
/// - [opacity]: The opacity of the background content. Default is 0.3.
/// - [titleTextStyle]: Optional text style for the title.
/// - [padding]: Padding for the dialog content. Default is `EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)`.
/// - [contentPadding]: Padding for the content widget. Default is `EdgeInsets.symmetric(vertical: 16.0)`.
/// - [buttonPadding]: Padding for the button row. Default is `EdgeInsets.only(top: 24.0)`.
/// - [gradient]: Optional gradient for the background.
/// - [automatoBackground]: Optional custom background widget.
/// - [fontSize]: Font size for the title text. Default is 24.
/// - [fontWeight]: Font weight for the title text. Default is FontWeight.bold.
/// - [boxShadow]: Optional box shadow for the dialog.
/// - [linesConfig]: Configuration for the background lines.
///
/// ## Example Usage:
/// ```dart
/// AutomatoDialog(
///   title: 'Confirmation',
///   content: Text('Are you sure you want to proceed?'),
///   onYesPressed: () {
///     print('Yes pressed');
///   },
///   onNoPressed: () {
///     print('No pressed');
///   },
///   yesLabel: 'Confirm',
///   noLabel: 'Cancel',
///   backgroundColor: Colors.white,
///   titleColor: Colors.black,
///   yesButtonColor: Colors.green,
///   noButtonColor: Colors.red,
///   borderRadius: 16.0,
///   elevation: 12.0,
/// )
/// ```
class AutomatoDialog extends ConsumerWidget {
  final String title;
  final Widget content;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;
  final String yesLabel;
  final String noLabel;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? yesButtonColor;
  final Color? noButtonColor;
  final Color? startColor;
  final Color? activeHoverColorYes;
  final Color? activeHoverColorNo;
  final bool showYesPointer;
  final bool showNoPointer;
  final double maxWidth;
  final double borderRadius;
  final double elevation;
  final double opacity;
  final TextStyle? titleTextStyle;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry buttonPadding;
  final LinearGradient? gradient;
  final AutomatoBackground? automatoBackground;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BoxShadow? boxShadow;
  final LinesConfig linesConfig;

  const AutomatoDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onYesPressed,
    required this.onNoPressed,
    this.yesLabel = 'Yes',
    this.noLabel = 'No',
    this.backgroundColor,
    this.titleColor,
    this.startColor,
    this.yesButtonColor,
    this.noButtonColor,
    this.activeHoverColorYes,
    this.activeHoverColorNo,
    this.showYesPointer = true,
    this.showNoPointer = true,
    this.maxWidth = 800,
    this.borderRadius = 20.0,
    this.elevation = 10.0,
    this.opacity = 0.3,
    this.titleTextStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    this.contentPadding = const EdgeInsets.symmetric(vertical: 16.0),
    this.buttonPadding = const EdgeInsets.only(top: 24.0),
    this.gradient,
    this.automatoBackground,
    this.fontSize = 24,
    this.fontWeight = FontWeight.bold,
    this.boxShadow,
    this.linesConfig = const LinesConfig(
        strokeWidth: 2,
        spacing: 5,
        flickerDuration: Duration(milliseconds: 3000),
        enableFlicker: false,
        drawHorizontalLines: true,
        drawVerticalLines: true,
        lineColor: Colors.white),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: Dialog(
        backgroundColor:
            backgroundColor ?? AutomatoThemeColors.primaryColor(ref),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    colors: [
                      AutomatoThemeColors.gradient(ref),
                      AutomatoThemeColors.primaryColor(ref),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                boxShadow ??
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
              ],
            ),
            padding: const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: opacity,
                      child: automatoBackground ??
                          AutomatoBackground(
                            showMenuLines: true,
                            showRepeatingBorders: false,
                            linesConfig: linesConfig,
                            backgroundSvgConfig: const BackgroundSvgConfig(
                              svgInnerString:
                                  AutomatoSvgStrings.automatoSvgStrCrackedGladd,
                              svgOuterString:
                                  AutomatoSvgStrings.automatoSvgStrCrackedGladd,
                              animateInner: true,
                              animateOuter: true,
                              showDual: true,
                            ),
                            backgroundColor:
                                AutomatoThemeColors.primaryColor(ref),
                            ref: ref,
                          ),
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            title,
                            style: titleTextStyle ??
                                TextStyle(
                                  color: titleColor ??
                                      AutomatoThemeColors.textDialogColor(ref),
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: contentPadding,
                          child: content,
                        ),
                        Padding(
                          padding: buttonPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AutomatoButton(
                                label: yesLabel,
                                onPressed: onYesPressed,
                                showPointer: showYesPointer,
                                uniqueId: 'yes_button',
                                activeHoverColor: activeHoverColorYes ??
                                    AutomatoThemeColors.saveZone(ref),
                                startColor: startColor ??
                                    AutomatoThemeColors.primaryColor(ref),
                                baseColor: yesButtonColor ??
                                    AutomatoThemeColors.darkBrown(ref),
                              ),
                              AutomatoButton(
                                label: noLabel,
                                onPressed: onNoPressed,
                                showPointer: showNoPointer,
                                uniqueId: 'no_button',
                                activeHoverColor: activeHoverColorNo ??
                                    AutomatoThemeColors.dangerZone(ref),
                                startColor: startColor ??
                                    AutomatoThemeColors.primaryColor(ref),
                                baseColor: noButtonColor ??
                                    AutomatoThemeColors.darkBrown(ref),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
