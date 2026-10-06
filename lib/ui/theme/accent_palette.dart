import 'package:flutter/material.dart';

/// The selectable accent colors: a short, curated list. Anything else is the
/// user's custom color, so a stored accent that left this list still resolves.
abstract final class AccentPalette {
  const new _();

  static const Color emerald = Color(0xFF10B981);
  static const Color royalBlue = Color(0xFF2563EB);
  static const Color violet = Color(0xFF7C3AED);
  static const Color rose = Color(0xFFE11D48);
  static const Color tangerine = Color(0xFFEA580C);

  static const Color defaultAccent = emerald;

  static const List<Color> colors = [
    emerald,
    royalBlue,
    violet,
    rose,
    tangerine,
  ];
}
