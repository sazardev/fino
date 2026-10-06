import 'package:flutter/material.dart';

import '../../ui/theme/accent_palette.dart';
import 'appearance_labels.dart';

/// A ready-made look: a theme mode and an accent that go well together. It
/// never touches the interface size, which is personal and has its own
/// control.
class AppearancePreset {
  const new({
    required this.label,
    required this.themeMode,
    required this.accent,
    required this.accentName,
  });

  final String label;
  final ThemeMode themeMode;
  final Color accent;
  final String accentName;

  /// "Oscuro · Violeta": what applying it will do, in plain words.
  String get hint => '${themeModeLabel(themeMode)} · $accentName';

  bool matches(ThemeMode mode, Color color) =>
      mode == themeMode && color.toARGB32() == accent.toARGB32();

  /// The preset the current settings amount to, if any.
  static AppearancePreset? matching(ThemeMode mode, Color color) {
    for (final p in all) {
      if (p.matches(mode, color)) return p;
    }
    return null;
  }

  static const all = [
    AppearancePreset(
      label: 'Esmeralda',
      themeMode: ThemeMode.system,
      accent: AccentPalette.emerald,
      accentName: 'Esmeralda',
    ),
    AppearancePreset(
      label: 'Océano',
      themeMode: ThemeMode.light,
      accent: AccentPalette.royalBlue,
      accentName: 'Azul real',
    ),
    AppearancePreset(
      label: 'Medianoche',
      themeMode: ThemeMode.dark,
      accent: AccentPalette.violet,
      accentName: 'Violeta',
    ),
    AppearancePreset(
      label: 'Rosé',
      themeMode: ThemeMode.light,
      accent: AccentPalette.rose,
      accentName: 'Rosa',
    ),
    AppearancePreset(
      label: 'Atardecer',
      themeMode: ThemeMode.dark,
      accent: AccentPalette.tangerine,
      accentName: 'Mandarina',
    ),
    AppearancePreset(
      label: 'Bosque',
      themeMode: ThemeMode.dark,
      accent: AccentPalette.emerald,
      accentName: 'Esmeralda',
    ),
  ];
}
