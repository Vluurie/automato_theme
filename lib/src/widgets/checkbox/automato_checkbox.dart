import 'package:flutter/material.dart';
import 'package:automato_theme/automato_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
/// ## Example Usage:
/// ```dart
/// AutomatoCheckBox(
///   initialValue: true,
///   text: 'Remember Me',
///   onChanged: (bool? value) {
///     print('Checkbox changed: $value');
///   },
///   fillColorChecked: Colors.green,
///   fillColorUnchecked: Colors.red,
///   fillColorDisabled: Colors.grey,
///   textColorChecked: Colors.black,
///   textColorUnchecked: Colors.black54,
///   borderRadius: 4.0,
///   padding: EdgeInsets.all(8.0),
///   textStyle: TextStyle(fontSize: 16),
///   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
/// )
/// ```
class AutomatoCheckBox extends ConsumerStatefulWidget {
  final bool initialValue;
  final ValueChanged<bool?>? onChanged;
  final String text;
  final Color? fillColorChecked;
  final Color? fillColorUnchecked;
  final Color? fillColorDisabled;
  final Color? textColorChecked;
  final Color? textColorUnchecked;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final List<BoxShadow>? boxShadow;

  const AutomatoCheckBox({
    super.key,
    required this.initialValue,
    this.onChanged,
    required this.text,
    this.fillColorChecked,
    this.fillColorUnchecked,
    this.fillColorDisabled,
    this.textColorChecked,
    this.textColorUnchecked,
    this.borderRadius = 2.0,
    this.padding = const EdgeInsets.only(right: 6.0),
    this.textStyle,
    this.boxShadow,
  });

  @override
  AutomatoCheckBoxState createState() => AutomatoCheckBoxState();
}

class AutomatoCheckBoxState extends ConsumerState<AutomatoCheckBox> {
  late bool checkboxValue;

  @override
  void initState() {
    super.initState();
    checkboxValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(AutomatoCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        checkboxValue = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveFillColorChecked =
        widget.fillColorChecked ?? AutomatoThemeColors.saveZone(ref);
    final effectiveFillColorUnchecked =
        widget.fillColorUnchecked ?? AutomatoThemeColors.darkBrown(ref);
    final effectiveFillColorDisabled =
        widget.fillColorDisabled ?? AutomatoThemeColors.dangerZone(ref);
    final effectiveTextColorChecked =
        widget.textColorChecked ?? AutomatoThemeColors.primaryColor(ref);
    final effectiveTextColorUnchecked =
        widget.textColorUnchecked ?? AutomatoThemeColors.dangerZone(ref);

    return Container(
      decoration: BoxDecoration(
        color: effectiveFillColorUnchecked,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: widget.boxShadow ??
            [
              BoxShadow(
                color: effectiveFillColorUnchecked.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 0,
                offset: const Offset(3, 3),
              ),
            ],
      ),
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
            fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.disabled)) {
                return effectiveFillColorDisabled;
              }
              return checkboxValue
                  ? effectiveFillColorChecked
                  : effectiveFillColorUnchecked;
            }),
            value: checkboxValue,
            onChanged: (bool? newValue) {
              setState(() {
                checkboxValue = newValue ?? false;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(checkboxValue);
              }
            },
          ),
          Text(
            widget.text,
            style: widget.textStyle ??
                TextStyle(
                  color: checkboxValue
                      ? effectiveTextColorChecked
                      : effectiveTextColorUnchecked,
                ),
          ),
        ],
      ),
    );
  }
}
