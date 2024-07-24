import 'package:automato_theme/automato_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A customizable single-button dialog widget that integrates with the Automato theme
/// and uses Riverpod for state management.
///
/// This widget provides a dialog with extensive customization options,
/// including colors for the background, title, button, and text styles.
/// It also supports adding a gradient, custom background, and animations.
///
/// ## Parameters:
/// - [title]: The title of the dialog.
/// - [content]: The content widget of the dialog.
/// - [onOkPressed]: The callback that is called when the OK button is pressed.
/// - [okLabel]: The label of the OK button. Default is 'OK'.
/// - [backgroundColor]: Optional background color for the dialog.
/// - [titleColor]: Optional color for the title text.
/// - [okButtonColor]: Optional background color for the OK button.
/// - [startColor]: Optional start color for the gradient.
/// - [activeHoverColorOk]: Optional hover color for the OK button.
/// - [maxWidth]: The maximum width of the dialog. Default is 800.
/// - [borderRadius]: The border radius of the dialog. Default is 20.0.
/// - [elevation]: The elevation of the dialog. Default is 10.0.
/// - [opacity]: The opacity of the background content. Default is 0.3.
/// - [titleTextStyle]: Optional text style for the title.
/// - [padding]: Padding for the dialog content. Default is `EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)`.
/// - [contentPadding]: Padding for the content widget. Default is `EdgeInsets.symmetric(vertical: 16.0)`.
/// - [buttonPadding]: Padding for the button. Default is `EdgeInsets.only(top: 24.0)`.
/// - [gradient]: Optional gradient for the background.
/// - [automatoBackground]: Optional custom background widget.
/// - [fontSize]: Font size for the title text. Default is 24.
/// - [fontWeight]: Font weight for the title text. Default is FontWeight.bold.
/// - [boxShadow]: Optional box shadow for the dialog.
///
/// ## Example Usage:
/// ```dart
/// AutomatoSingleButtonDialog(
///   title: 'Information',
///   content: Text('This is an informational dialog.'),
///   onOkPressed: () {
///     print('OK pressed');
///   },
///   okLabel: 'Got it',
///   backgroundColor: Colors.white,
///   titleColor: Colors.black,
///   okButtonColor: Colors.blue,
///   borderRadius: 16.0,
///   elevation: 12.0,
/// )
/// ```
class AutomatoSingleButtonDialog extends ConsumerWidget {
  final String title;
  final Widget content;
  final VoidCallback onOkPressed;
  final String okLabel;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? okButtonColor;
  final Color? startColor;
  final Color? activeHoverColorOk;
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

  const AutomatoSingleButtonDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onOkPressed,
    this.okLabel = 'OK',
    this.backgroundColor,
    this.titleColor,
    this.startColor,
    this.okButtonColor,
    this.activeHoverColorOk,
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
                            showMenuLines: false,
                            showRepeatingBorders: false,
                            backgroundSvgConfig: const BackgroundSvgConfig(
                              svgInnerString:
                                  AutomatoSvgStrings.automatoSvgStrPointer,
                              svgOuterString:
                                  AutomatoSvgStrings.automatoSvgStrPointer,
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
                          child: Center(
                            child: AutomatoButton(
                              label: okLabel,
                              onPressed: onOkPressed,
                              uniqueId: 'ok_button',
                              activeHoverColor: activeHoverColorOk ??
                                  AutomatoThemeColors.saveZone(ref),
                              startColor: startColor ??
                                  AutomatoThemeColors.primaryColor(ref),
                              baseColor: okButtonColor ??
                                  AutomatoThemeColors.darkBrown(ref),
                            ),
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
