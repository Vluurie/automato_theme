import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../state_managment/provider/automato_provider.dart';

/// A widget that displays an SVG with optional fading animations controlled by a visibility state.
///
/// Parameters:
///   - [svgString]: The required SVG for the pointer.
///   - [width]: The width of the SVG.
///   - [color]: The color to apply to the SVG. If null, the SVG will retain its original colors.
///   - [uniqueId]: A unique identifier used to manage visibility state through a provider.
///   - [aspectRatio]: The aspect ratio (width / height) of the SVG. Defaults to the common aspect ratio of the pointer SVG.
///   - [animationDuration]: The duration of the fade animation. Defaults to 300 milliseconds.
class AutomatoPointerSVG extends ConsumerWidget {
  final String svgString;
  final double width;
  final Color? color;
  final String uniqueId;
  final double aspectRatio;
  final Duration animationDuration;

  /// Constructs an instance of [AutomatoPointerSVG].
  ///
  /// Requires [svgString], [width] and [uniqueId] to not be null.
  const AutomatoPointerSVG({
    super.key,
    required this.svgString,
    required this.width,
    this.color,
    required this.uniqueId,
    this.aspectRatio =
        367.705 / 234.894, // Default aspect ratio; can be overridden
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the visibility state based on the uniqueId.
    final isVisible = ref.watch(svgVisibilityProvider(uniqueId));

    return AnimatedOpacity(
      opacity: isVisible
          ? 1.0
          : 0.0, // Fully visible when true, fully transparent when false.
      duration: animationDuration, // Duration of the fade effect.
      child: SvgPicture.string(
        svgString, // The SVG data as a string.
        width: width,
        height: width *
            aspectRatio, // Calculate height based on the provided aspect ratio.
        color: color, // Apply the specified color or use the default if null.
        colorBlendMode: color != null
            ? BlendMode.srcIn
            : BlendMode.dst, // Blend mode for the color.
      ),
    );
  }
}
