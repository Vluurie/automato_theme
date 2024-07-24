import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider for the svg unique ID primary used for the pointer svg.
final svgVisibilityProvider =
    StateProvider.family<bool, String>((ref, uniqueId) => false);
