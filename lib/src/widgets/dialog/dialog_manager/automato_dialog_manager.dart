import 'package:automato_theme/src/widgets/dialog/dialog_manager/automato_dialog_single.dart';
import 'package:automato_theme/src/widgets/dialog/dialog_manager/dialogs/automato_general_dialog.dart';
import 'package:flutter/material.dart';
import 'package:automato_theme/automato_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A manager class for displaying customized dialogs in the Automato theme.
///
/// The `AutomatoDialogManager` class provides methods to display different types
/// of dialogs, including a yes/no confirmation dialog and an informational dialog.
/// It leverages the `showAutomatoDialog` function to present these dialogs with
/// complex animations and extensive customization options.
///
/// ## Methods:
/// - [showYesNoDialog]: Displays a dialog with Yes and No buttons.
/// - [showInfoDialog]: Displays a dialog with a single OK button.

class AutomatoDialogManager {
  /// Displays a customizable yes/no dialog.
  ///
  /// This method shows a dialog with Yes and No buttons, using the provided
  /// parameters for extensive customization. The dialog can have custom colors,
  /// text styles, gradients, and animations.
  ///
  /// ## Parameters:
  /// - [context]: The build context in which to show the dialog.
  /// - [ref]: A reference to the Riverpod provider for theme and state management.
  /// - [title]: The title of the dialog.
  /// - [content]: The content widget of the dialog.
  /// - [onYesPressed]: The callback that is called when the Yes button is pressed.
  /// - [onNoPressed]: The callback that is called when the No button is pressed.
  /// - [yesLabel]: The label of the Yes button. Default is 'Yes'.
  /// - [noLabel]: The label of the No button. Default is 'No'.
  /// - [backgroundColor]: Optional background color for the dialog.
  /// - [titleColor]: Optional color for the title text.
  /// - [yesButtonColor]: Optional background color for the Yes button.
  /// - [noButtonColor]: Optional background color for the No button.
  /// - [startColor]: Optional start color for the gradient.
  /// - [activeHoverColorYes]: Optional hover color for the Yes button.
  /// - [activeHoverColorNo]: Optional hover color for the No button.
  /// - [showYesPointer]: Whether to show a pointer on the Yes button. Default is true.
  /// - [showNoPointer]: Whether to show a pointer on the No button. Default is true.
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
  void showYesNoDialog({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required Widget content,
    required VoidCallback onYesPressed,
    required VoidCallback onNoPressed,
    String yesLabel = 'Yes',
    String noLabel = 'No',
    Color? backgroundColor,
    Color? titleColor,
    Color? yesButtonColor,
    Color? noButtonColor,
    Color? startColor,
    Color? activeHoverColorYes,
    Color? activeHoverColorNo,
    bool showYesPointer = true,
    bool showNoPointer = true,
    double maxWidth = 800,
    double borderRadius = 20.0,
    double elevation = 10.0,
    double opacity = 0.3,
    TextStyle? titleTextStyle,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.symmetric(vertical: 16.0),
    EdgeInsetsGeometry buttonPadding = const EdgeInsets.only(top: 24.0),
    LinearGradient? gradient,
    AutomatoBackground? automatoBackground,
    double? fontSize = 24,
    FontWeight? fontWeight = FontWeight.bold,
    BoxShadow? boxShadow,
    LinesConfig linesConfig = const LinesConfig(
        strokeWidth: 2,
        spacing: 5,
        flickerDuration: Duration(milliseconds: 3000),
        enableFlicker: false,
        drawHorizontalLines: true,
        drawVerticalLines: true,
        lineColor: Colors.white),
  }) {
    showAutomatoDialog(
      context: context,
      ref: ref,
      dialog: AutomatoDialog(
        title: title,
        content: content,
        onYesPressed: onYesPressed,
        onNoPressed: onNoPressed,
        yesLabel: yesLabel,
        noLabel: noLabel,
        backgroundColor: backgroundColor,
        titleColor: titleColor,
        yesButtonColor: yesButtonColor,
        noButtonColor: noButtonColor,
        startColor: startColor,
        activeHoverColorYes: activeHoverColorYes,
        activeHoverColorNo: activeHoverColorNo,
        showYesPointer: showYesPointer,
        showNoPointer: showNoPointer,
        maxWidth: maxWidth,
        borderRadius: borderRadius,
        elevation: elevation,
        opacity: opacity,
        titleTextStyle: titleTextStyle,
        padding: padding,
        contentPadding: contentPadding,
        buttonPadding: buttonPadding,
        gradient: gradient,
        automatoBackground: automatoBackground,
        fontSize: fontSize,
        fontWeight: fontWeight,
        boxShadow: boxShadow,
        linesConfig: linesConfig,
      ),
    );
  }

  /// Displays a customizable informational dialog.
  ///
  /// This method shows a dialog with a single OK button, using the provided
  /// parameters for extensive customization. The dialog can have custom colors,
  /// text styles, gradients, and animations.
  ///
  /// ## Parameters:
  /// - [context]: The build context in which to show the dialog.
  /// - [ref]: A reference to the Riverpod provider for theme and state management.
  /// - [title]: The title of the dialog.
  /// - [content]: The content widget of the dialog.
  /// - [onOkPressed]: The callback that is called when the OK button is pressed.
  /// - [okLabel]: The label of the OK button. Default is 'OK'.
  /// - [backgroundColor]: Optional background color for the dialog.
  /// - [titleColor]: Optional color for the title text.
  /// - [okButtonColor]: Optional background color for the OK button.
  /// - [startColor]: Optional start color for the gradient.
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
  void showInfoDialog({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required Widget content,
    required VoidCallback onOkPressed,
    String okLabel = 'OK',
    Color? backgroundColor,
    Color? titleColor,
    Color? okButtonColor,
    Color? startColor,
    double maxWidth = 800,
    double borderRadius = 20.0,
    double elevation = 10.0,
    double opacity = 0.3,
    TextStyle? titleTextStyle,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.symmetric(vertical: 16.0),
    EdgeInsetsGeometry buttonPadding = const EdgeInsets.only(top: 24.0),
    LinearGradient? gradient,
    AutomatoBackground? automatoBackground,
    double? fontSize = 24,
    FontWeight? fontWeight = FontWeight.bold,
    BoxShadow? boxShadow,
  }) {
    showAutomatoDialog(
      context: context,
      ref: ref,
      dialog: AutomatoSingleButtonDialog(
        title: title,
        content: content,
        onOkPressed: onOkPressed,
        okLabel: okLabel,
        backgroundColor: backgroundColor,
        titleColor: titleColor,
        okButtonColor: okButtonColor,
        startColor: startColor,
        maxWidth: maxWidth,
        borderRadius: borderRadius,
        elevation: elevation,
        opacity: opacity,
        titleTextStyle: titleTextStyle,
        padding: padding,
        contentPadding: contentPadding,
        buttonPadding: buttonPadding,
        gradient: gradient,
        automatoBackground: automatoBackground,
        fontSize: fontSize,
        fontWeight: fontWeight,
        boxShadow: boxShadow,
      ),
    );
  }
}
