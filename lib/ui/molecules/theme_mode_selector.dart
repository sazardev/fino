import 'package:flutter/material.dart';

import 'flat_segmented_button.dart';

/// System / Light / Dark.
class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  final ThemeMode mode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return FlatSegmentedButton<ThemeMode>(
      segments: const [
        (ThemeMode.system, 'Sistema'),
        (ThemeMode.light, 'Claro'),
        (ThemeMode.dark, 'Oscuro'),
      ],
      selected: mode,
      onChanged: onChanged,
    );
  }
}
