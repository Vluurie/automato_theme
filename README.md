# Automato Theme

An elegant and futuristic theme inspired by the Nier: Automata game.

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
  automato_theme: latest_version
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

The AutomatoBackground widget allows you to set a stylish background for your app with various customization options.

```dart
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

The AutomatoCheckBox widget provides a customizable checkbox with theme-aware colors and fast state managment.

```dart
Code kopieren
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

The AutomatoButton widget allows you to create buttons with automata styling and are highly customizable.

```dart
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
The AutomatoLoading widget shows a themed loading animation.

```dart
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