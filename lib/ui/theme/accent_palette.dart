import 'package:flutter/material.dart';

/// The 32 selectable accent colors.
///
/// Append only: never reorder or remove entries, so stored choices keep
/// resolving.
abstract final class AccentPalette {
  const new _();

  static const Color defaultAccent = Color(0xFF10B981); // emerald

  static const List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
    Color(0xFFE11D48), // rose
    Color(0xFFF43F5E), // coral
    Color(0xFFD946EF), // fuchsia
    Color(0xFF7C3AED), // violet
    Color(0xFF6366F1), // periwinkle
    Color(0xFF2563EB), // royal blue
    Color(0xFF0EA5E9), // sky
    Color(0xFF14B8A6), // aqua
    defaultAccent, // emerald
    Color(0xFF84CC16), // pear
    Color(0xFFF59E0B), // honey
    Color(0xFFEA580C), // tangerine
    Color(0xFF8B5E3C), // cocoa
    Color(0xFF64748B), // slate
    Color(0xFF334155), // midnight
    Color(0xFF111827), // ink
  ];
}
