import 'package:flutter/material.dart';

import '../../ui/molecules/collapsible_section.dart';
import '../../ui/organisms/accent_picker.dart';
import '../../ui/theme/accent_palette.dart';
import 'app_settings.dart';

/// The five curated accents, plus a custom color.
class AppearanceAccentSection extends StatelessWidget {
  const new({required this.settings, super.key});

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: settings.accent,
      builder: (context, color, _) => CollapsibleSection(
        icon: Icons.palette_rounded,
        title: 'Color de acento',
        summary: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: AccentPicker(
            colors: AccentPalette.colors,
            color: color,
            swatchSize: 44,
            onChanged: settings.accent.update,
          ),
        ),
      ),
    );
  }
}
