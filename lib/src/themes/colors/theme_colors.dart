import 'package:flutter/material.dart';
import 'package:automato_theme/src/themes/colors/angel_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/cyberpunk_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/danger_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/desert_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/floral_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/futuristic_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/ice_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/lava_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/neon_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/nightmare_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/pastel_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/retro_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/steampunk_theme_colors.dart';
import 'package:automato_theme/src/themes/colors/sunset_theme_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The AutomatoThemeNotifier is responsible for managing and switching themes
/// within the Automato application. It extends StateNotifier to manage the
/// theme state and provides methods to switch between predefined themes
/// and persist the selected theme using SharedPreferences.
class AutomatoThemeNotifier extends StateNotifier<ThemeState> {
  AutomatoThemeNotifier(super.state);

  /// Sets the current theme to the specified theme and colors,
  /// and saves the theme name to preferences.
  Future<void> setTheme(
      ThemeData theme, Map<String, Color> colors, String themeName) async {
    await Future.delayed(const Duration(milliseconds: 300));
    state = ThemeState(theme: theme, colors: colors);
    _saveThemeToPreferences(themeName);
  }

  /// Saves the selected theme name to shared preferences.
  Future<void> _saveThemeToPreferences(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_theme', themeName);
  }

  /// Loads the theme from shared preferences and returns an instance
  /// of AutomatoThemeNotifier initialized with the saved theme.
  static Future<AutomatoThemeNotifier> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('selected_theme') ?? 'default';
    ThemeData theme;
    Map<String, Color> colors;

    switch (themeName) {
      case 'angel':
        theme = angelTheme;
        colors = angelColors;
        break;
      case 'cyberpunk':
        theme = cyberpunkTheme;
        colors = cyberpunkColors;
        break;
      case 'danger':
        theme = dangerTheme;
        colors = dangerColors;
        break;
      case 'desert':
        theme = desertTheme;
        colors = desertColors;
        break;
      case 'floral':
        theme = floralTheme;
        colors = floralColors;
        break;
      case 'futuristic':
        theme = futuristicTheme;
        colors = futuristicColors;
        break;
      case 'ice':
        theme = iceTheme;
        colors = iceColors;
        break;
      case 'lava':
        theme = lavaTheme;
        colors = lavaColors;
        break;
      case 'neon':
        theme = neonTheme;
        colors = neonColors;
        break;
      case 'nightmare':
        theme = nightmareTheme;
        colors = nightmareColors;
        break;
      case 'pastel':
        theme = pastelTheme;
        colors = pastelColors;
        break;
      case 'retro':
        theme = retroTheme;
        colors = retroColors;
        break;
      case 'steampunk':
        theme = steampunkTheme;
        colors = steampunkColors;
        break;
      case 'sunset':
        theme = sunsetTheme;
        colors = sunsetColors;
        break;
      default:
        theme = defaultTheme;
        colors = defaultColors;
        break;
    }

    return AutomatoThemeNotifier(ThemeState(theme: theme, colors: colors));
  }

  // Default theme configuration
  static final ThemeData defaultTheme = ThemeData.dark();

  static final Map<String, Color> defaultColors = {
    'primaryColor': const Color.fromARGB(255, 191, 178, 148),
    'gradientStartColor': const Color.fromRGBO(0, 0, 0, 0.024),
    'transparentColor': Colors.transparent,
    'brown': const Color.fromRGBO(72, 70, 61, 1),
    'brown25': const Color.fromRGBO(72, 70, 61, .25),
    'brown15': const Color.fromRGBO(72, 70, 61, .15),
    'brown025': const Color.fromRGBO(72, 70, 61, .025),
    'darkBrown': const Color.fromRGBO(69, 67, 58, 1),
    'hoverBrown': const Color.fromRGBO(119, 116, 98, 1),
    'tan': const Color.fromRGBO(194, 189, 166, 1),
    'bright': const Color.fromARGB(255, 223, 221, 216),
    'dangerZone': const Color.fromRGBO(255, 0, 0, 1),
    'saveZone': const Color.fromRGBO(0, 255, 0, 1),
    'selected': const Color.fromRGBO(255, 136, 0, 1),
    'gradient': const Color.fromARGB(255, 221, 219, 212),
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  // Predefined themes and their corresponding color configurations
  static final ThemeData angelTheme = ThemeData.dark().copyWith(
    primaryColor: AngelThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> angelColors = {
    'primaryColor': AngelThemeColors.primaryColor,
    'gradientStartColor': AngelThemeColors.gradientStartColor,
    'transparentColor': AngelThemeColors.transparentColor,
    'brown': AngelThemeColors.brown,
    'brown25': AngelThemeColors.brown25,
    'brown15': AngelThemeColors.brown15,
    'brown025': AngelThemeColors.brown025,
    'darkBrown': AngelThemeColors.darkBrown,
    'hoverBrown': AngelThemeColors.hoverBrown,
    'tan': AngelThemeColors.tan,
    'bright': AngelThemeColors.bright,
    'dangerZone': AngelThemeColors.dangerZone,
    'saveZone': AngelThemeColors.saveZone,
    'selected': AngelThemeColors.selected,
    'gradient': AngelThemeColors.gradient,
    'textColor': AngelThemeColors.textColor,
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData cyberpunkTheme = ThemeData.dark().copyWith(
    primaryColor: CyberpunkThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> cyberpunkColors = {
    'primaryColor': CyberpunkThemeColors.primaryColor,
    'gradientStartColor': CyberpunkThemeColors.gradientStartColor,
    'transparentColor': CyberpunkThemeColors.transparentColor,
    'brown': CyberpunkThemeColors.brown,
    'brown25': CyberpunkThemeColors.brown25,
    'brown15': CyberpunkThemeColors.brown15,
    'brown025': CyberpunkThemeColors.brown025,
    'darkBrown': CyberpunkThemeColors.darkBrown,
    'hoverBrown': CyberpunkThemeColors.hoverBrown,
    'tan': CyberpunkThemeColors.tan,
    'bright': CyberpunkThemeColors.bright,
    'dangerZone': CyberpunkThemeColors.dangerZone,
    'saveZone': CyberpunkThemeColors.saveZone,
    'selected': CyberpunkThemeColors.selected,
    'gradient': CyberpunkThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData dangerTheme = ThemeData.dark().copyWith(
    primaryColor: DangerThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> dangerColors = {
    'primaryColor': DangerThemeColors.primaryColor,
    'gradientStartColor': DangerThemeColors.gradientStartColor,
    'transparentColor': DangerThemeColors.transparentColor,
    'brown': DangerThemeColors.brown,
    'brown25': DangerThemeColors.brown25,
    'brown15': DangerThemeColors.brown15,
    'brown025': DangerThemeColors.brown025,
    'darkBrown': DangerThemeColors.darkBrown,
    'hoverBrown': DangerThemeColors.hoverBrown,
    'tan': DangerThemeColors.tan,
    'bright': DangerThemeColors.bright,
    'dangerZone': DangerThemeColors.dangerZone,
    'saveZone': DangerThemeColors.saveZone,
    'selected': DangerThemeColors.selected,
    'gradient': DangerThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData desertTheme = ThemeData.dark().copyWith(
    primaryColor: DesertThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> desertColors = {
    'primaryColor': DesertThemeColors.primaryColor,
    'gradientStartColor': DesertThemeColors.gradientStartColor,
    'transparentColor': DesertThemeColors.transparentColor,
    'brown': DesertThemeColors.brown,
    'brown25': DesertThemeColors.brown25,
    'brown15': DesertThemeColors.brown15,
    'brown025': DesertThemeColors.brown025,
    'darkBrown': DesertThemeColors.darkBrown,
    'hoverBrown': DesertThemeColors.hoverBrown,
    'tan': DesertThemeColors.tan,
    'bright': DesertThemeColors.bright,
    'dangerZone': DesertThemeColors.dangerZone,
    'saveZone': DesertThemeColors.saveZone,
    'selected': DesertThemeColors.selected,
    'gradient': DesertThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData floralTheme = ThemeData.dark().copyWith(
    primaryColor: FloralThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> floralColors = {
    'primaryColor': FloralThemeColors.primaryColor,
    'gradientStartColor': FloralThemeColors.gradientStartColor,
    'transparentColor': FloralThemeColors.transparentColor,
    'brown': FloralThemeColors.brown,
    'brown25': FloralThemeColors.brown25,
    'brown15': FloralThemeColors.brown15,
    'brown025': FloralThemeColors.brown025,
    'darkBrown': FloralThemeColors.darkBrown,
    'hoverBrown': FloralThemeColors.hoverBrown,
    'tan': FloralThemeColors.tan,
    'bright': FloralThemeColors.bright,
    'dangerZone': FloralThemeColors.dangerZone,
    'saveZone': FloralThemeColors.saveZone,
    'selected': FloralThemeColors.selected,
    'gradient': FloralThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData futuristicTheme = ThemeData.dark().copyWith(
    primaryColor: FuturisticThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> futuristicColors = {
    'primaryColor': FuturisticThemeColors.primaryColor,
    'gradientStartColor': FuturisticThemeColors.gradientStartColor,
    'transparentColor': FuturisticThemeColors.transparentColor,
    'brown': FuturisticThemeColors.brown,
    'brown25': FuturisticThemeColors.brown25,
    'brown15': FuturisticThemeColors.brown15,
    'brown025': FuturisticThemeColors.brown025,
    'darkBrown': FuturisticThemeColors.darkBrown,
    'hoverBrown': FuturisticThemeColors.hoverBrown,
    'tan': FuturisticThemeColors.tan,
    'bright': FuturisticThemeColors.bright,
    'dangerZone': FuturisticThemeColors.dangerZone,
    'saveZone': FuturisticThemeColors.saveZone,
    'selected': FuturisticThemeColors.selected,
    'gradient': FuturisticThemeColors.gradient,
    'textColor': FuturisticThemeColors.textColor,
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData iceTheme = ThemeData.dark().copyWith(
    primaryColor: IceThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> iceColors = {
    'primaryColor': IceThemeColors.primaryColor,
    'gradientStartColor': IceThemeColors.gradientStartColor,
    'transparentColor': IceThemeColors.transparentColor,
    'brown': IceThemeColors.brown,
    'brown25': IceThemeColors.brown25,
    'brown15': IceThemeColors.brown15,
    'brown025': IceThemeColors.brown025,
    'darkBrown': IceThemeColors.darkBrown,
    'hoverBrown': IceThemeColors.hoverBrown,
    'tan': IceThemeColors.tan,
    'bright': IceThemeColors.bright,
    'dangerZone': IceThemeColors.dangerZone,
    'saveZone': IceThemeColors.saveZone,
    'selected': IceThemeColors.selected,
    'gradient': IceThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData lavaTheme = ThemeData.dark().copyWith(
    primaryColor: LavaThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> lavaColors = {
    'primaryColor': LavaThemeColors.primaryColor,
    'gradientStartColor': LavaThemeColors.gradientStartColor,
    'transparentColor': LavaThemeColors.transparentColor,
    'brown': LavaThemeColors.brown,
    'brown25': LavaThemeColors.brown25,
    'brown15': LavaThemeColors.brown15,
    'brown025': LavaThemeColors.brown025,
    'darkBrown': LavaThemeColors.darkBrown,
    'hoverBrown': LavaThemeColors.hoverBrown,
    'tan': LavaThemeColors.tan,
    'bright': LavaThemeColors.bright,
    'dangerZone': LavaThemeColors.dangerZone,
    'saveZone': LavaThemeColors.saveZone,
    'selected': LavaThemeColors.selected,
    'gradient': LavaThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData neonTheme = ThemeData.dark().copyWith(
    primaryColor: NeonThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> neonColors = {
    'primaryColor': NeonThemeColors.primaryColor,
    'gradientStartColor': NeonThemeColors.gradientStartColor,
    'transparentColor': NeonThemeColors.transparentColor,
    'brown': NeonThemeColors.brown,
    'brown25': NeonThemeColors.brown25,
    'brown15': NeonThemeColors.brown15,
    'brown025': NeonThemeColors.brown025,
    'darkBrown': NeonThemeColors.darkBrown,
    'hoverBrown': NeonThemeColors.hoverBrown,
    'tan': NeonThemeColors.tan,
    'bright': NeonThemeColors.bright,
    'dangerZone': NeonThemeColors.dangerZone,
    'saveZone': NeonThemeColors.saveZone,
    'selected': NeonThemeColors.selected,
    'gradient': NeonThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData nightmareTheme = ThemeData.dark().copyWith(
    primaryColor: NightmareThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> nightmareColors = {
    'primaryColor': NightmareThemeColors.primaryColor,
    'gradientStartColor': NightmareThemeColors.gradientStartColor,
    'transparentColor': NightmareThemeColors.transparentColor,
    'brown': NightmareThemeColors.brown,
    'brown25': NightmareThemeColors.brown25,
    'brown15': NightmareThemeColors.brown15,
    'brown025': NightmareThemeColors.brown025,
    'darkBrown': NightmareThemeColors.darkBrown,
    'hoverBrown': NightmareThemeColors.hoverBrown,
    'tan': NightmareThemeColors.tan,
    'bright': NightmareThemeColors.bright,
    'dangerZone': NightmareThemeColors.dangerZone,
    'saveZone': NightmareThemeColors.saveZone,
    'selected': NightmareThemeColors.selected,
    'gradient': NightmareThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData pastelTheme = ThemeData.dark().copyWith(
    primaryColor: PastelThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> pastelColors = {
    'primaryColor': PastelThemeColors.primaryColor,
    'gradientStartColor': PastelThemeColors.gradientStartColor,
    'transparentColor': PastelThemeColors.transparentColor,
    'brown': PastelThemeColors.brown,
    'brown25': PastelThemeColors.brown25,
    'brown15': PastelThemeColors.brown15,
    'brown025': PastelThemeColors.brown025,
    'darkBrown': PastelThemeColors.darkBrown,
    'hoverBrown': PastelThemeColors.hoverBrown,
    'tan': PastelThemeColors.tan,
    'bright': PastelThemeColors.bright,
    'dangerZone': PastelThemeColors.dangerZone,
    'saveZone': PastelThemeColors.saveZone,
    'selected': PastelThemeColors.selected,
    'gradient': PastelThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData retroTheme = ThemeData.dark().copyWith(
    primaryColor: RetroThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> retroColors = {
    'primaryColor': RetroThemeColors.primaryColor,
    'gradientStartColor': RetroThemeColors.gradientStartColor,
    'transparentColor': RetroThemeColors.transparentColor,
    'brown': RetroThemeColors.brown,
    'brown25': RetroThemeColors.brown25,
    'brown15': RetroThemeColors.brown15,
    'brown025': RetroThemeColors.brown025,
    'darkBrown': RetroThemeColors.darkBrown,
    'hoverBrown': RetroThemeColors.hoverBrown,
    'tan': RetroThemeColors.tan,
    'bright': RetroThemeColors.bright,
    'dangerZone': RetroThemeColors.dangerZone,
    'saveZone': RetroThemeColors.saveZone,
    'selected': RetroThemeColors.selected,
    'gradient': RetroThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData steampunkTheme = ThemeData.dark().copyWith(
    primaryColor: SteamPunkThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> steampunkColors = {
    'primaryColor': SteamPunkThemeColors.primaryColor,
    'gradientStartColor': SteamPunkThemeColors.gradientStartColor,
    'transparentColor': SteamPunkThemeColors.transparentColor,
    'brown': SteamPunkThemeColors.brown,
    'brown25': SteamPunkThemeColors.brown25,
    'brown15': SteamPunkThemeColors.brown15,
    'brown025': SteamPunkThemeColors.brown025,
    'darkBrown': SteamPunkThemeColors.darkBrown,
    'hoverBrown': SteamPunkThemeColors.hoverBrown,
    'tan': SteamPunkThemeColors.tan,
    'bright': SteamPunkThemeColors.bright,
    'dangerZone': SteamPunkThemeColors.dangerZone,
    'saveZone': SteamPunkThemeColors.saveZone,
    'selected': SteamPunkThemeColors.selected,
    'gradient': SteamPunkThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  static final ThemeData sunsetTheme = ThemeData.dark().copyWith(
    primaryColor: SunsetThemeColors.primaryColor,
    // Additional properties can be added here
  );

  static final Map<String, Color> sunsetColors = {
    'primaryColor': SunsetThemeColors.primaryColor,
    'gradientStartColor': SunsetThemeColors.gradientStartColor,
    'transparentColor': SunsetThemeColors.transparentColor,
    'brown': SunsetThemeColors.brown,
    'brown25': SunsetThemeColors.brown25,
    'brown15': SunsetThemeColors.brown15,
    'brown025': SunsetThemeColors.brown025,
    'darkBrown': SunsetThemeColors.darkBrown,
    'hoverBrown': SunsetThemeColors.hoverBrown,
    'tan': SunsetThemeColors.tan,
    'bright': SunsetThemeColors.bright,
    'dangerZone': SunsetThemeColors.dangerZone,
    'saveZone': SunsetThemeColors.saveZone,
    'selected': SunsetThemeColors.selected,
    'gradient': SunsetThemeColors.gradient,
    'textColor': const Color.fromARGB(255, 255, 255, 255),
    'textDialogColor': const Color.fromARGB(255, 0, 0, 0),
  };

  /// Switches to the default theme.
  void switchToDefaultTheme() {
    setTheme(defaultTheme, defaultColors, 'default');
  }

  /// Switches to the angel theme.
  void switchToAngelTheme() {
    setTheme(angelTheme, angelColors, 'angel');
  }

  /// Switches to the cyberpunk theme.
  void switchToCyberpunkTheme() {
    setTheme(cyberpunkTheme, cyberpunkColors, 'cyberpunk');
  }

  /// Switches to the danger theme.
  void switchToDangerTheme() {
    setTheme(dangerTheme, dangerColors, 'danger');
  }

  /// Switches to the desert theme.
  void switchToDesertTheme() {
    setTheme(desertTheme, desertColors, 'desert');
  }

  /// Switches to the floral theme.
  void switchToFloralTheme() {
    setTheme(floralTheme, floralColors, 'floral');
  }

  /// Switches to the futuristic theme.
  void switchToFuturisticTheme() {
    setTheme(futuristicTheme, futuristicColors, 'futuristic');
  }

  /// Switches to the ice theme.
  void switchToIceTheme() {
    setTheme(iceTheme, iceColors, 'ice');
  }

  /// Switches to the lava theme.
  void switchToLavaTheme() {
    setTheme(lavaTheme, lavaColors, 'lava');
  }

  /// Switches to the neon theme.
  void switchToNeonTheme() {
    setTheme(neonTheme, neonColors, 'neon');
  }

  /// Switches to the nightmare theme.
  void switchToNightmareTheme() {
    setTheme(nightmareTheme, nightmareColors, 'nightmare');
  }

  /// Switches to the pastel theme.
  void switchToPastelTheme() {
    setTheme(pastelTheme, pastelColors, 'pastel');
  }

  /// Switches to the retro theme.
  void switchToRetroTheme() {
    setTheme(retroTheme, retroColors, 'retro');
  }

  /// Switches to the steampunk theme.
  void switchToSteampunkTheme() {
    setTheme(steampunkTheme, steampunkColors, 'steampunk');
  }

  /// Switches to the sunset theme.
  void switchToSunsetTheme() {
    setTheme(sunsetTheme, sunsetColors, 'sunset');
  }
}

/// Represents the state of the theme, including the ThemeData and color map.
class ThemeState {
  final ThemeData theme;
  final Map<String, Color> colors;

  ThemeState({required this.theme, required this.colors});
}

/// Provider for the AutomatoThemeNotifier.
final automatoThemeNotifierProvider =
    StateNotifierProvider<AutomatoThemeNotifier, ThemeState>((ref) {
  return AutomatoThemeNotifier(ThemeState(
      theme: AutomatoThemeNotifier.defaultTheme,
      colors: AutomatoThemeNotifier.defaultColors));
});

/// Utility class to access theme colors.
class AutomatoThemeColors {
  static Color primaryColor(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['primaryColor']!;
  static Color gradientStartColor(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['gradientStartColor']!;
  static Color transparentColor(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['transparentColor']!;
  static Color brown(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['brown']!;
  static Color brown25(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['brown25']!;
  static Color brown15(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['brown15']!;
  static Color brown025(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['brown025']!;
  static Color darkBrown(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['darkBrown']!;
  static Color hoverBrown(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['hoverBrown']!;
  static Color tan(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['tan']!;
  static Color bright(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['bright']!;
  static Color dangerZone(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['dangerZone']!;
  static Color saveZone(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['saveZone']!;
  static Color selected(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['selected']!;
  static Color gradient(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['gradient']!;
  static Color textColor(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['textColor']!;
  static Color textDialogColor(WidgetRef ref) =>
      ref.watch(automatoThemeNotifierProvider).colors['textDialogColor']!;
}
