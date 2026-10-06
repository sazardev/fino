import 'package:flutter/material.dart';

import '../../ui/design/app_spacing.dart';
import '../../ui/molecules/collapsible_section.dart';
import '../../ui/molecules/theme_mode_selector.dart';
import 'app_settings.dart';
import 'appearance_labels.dart';

/// Light, dark, or follow the device.
class AppearanceThemeSection extends StatelessWidget {
  const new({required this.settings, super.key});

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: settings.themeMode,
      builder: (context, mode, _) => CollapsibleSection(
        icon: Icons.contrast_rounded,
        title: 'Tema',
        initiallyExpanded: false,
        summary: Text(themeModeLabel(mode)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ThemeModeSelector(mode: mode, onChanged: settings.themeMode.update),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Sistema sigue el modo claro u oscuro de tu dispositivo.',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: muted),
            ),
          ],
        ),
      ),
    );
  }
}
