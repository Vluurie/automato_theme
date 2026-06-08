import 'package:flutter_riverpod/legacy.dart';

/// A provider for the svg unique ID primary used for the pointer svg.
final svgVisibilityProvider =
    StateProvider.family<bool, String>((ref, uniqueId) => false);
