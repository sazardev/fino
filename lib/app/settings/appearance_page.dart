import 'package:flutter/material.dart';

import '../../ui/design/app_spacing.dart';
import '../../ui/templates/settings_shell.dart';
import 'appearance_accent_section.dart';
import 'appearance_presets_section.dart';
import 'appearance_reset_row.dart';
import 'appearance_size_section.dart';
import 'appearance_theme_section.dart';
import 'settings_scope.dart';

/// Your UI, your way: ready-made looks, then each choice on its own — color,
/// theme and size. Each section folds away and shows its value when folded;
/// every choice applies live.
class AppearancePage extends StatelessWidget {
  const new({super.key, this.onBack});

  /// Where the back button leads; set by the route.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.of(context);
    const gap = SizedBox(height: AppSpacing.md);

    return SettingsShell(
      onBack: onBack,
      children: [
        const SizedBox(height: AppSpacing.sm),
        AppearancePresetsSection(settings: settings),
        gap,
        AppearanceAccentSection(settings: settings),
        gap,
        AppearanceThemeSection(settings: settings),
        gap,
        AppearanceSizeSection(settings: settings),
        const SizedBox(height: AppSpacing.xl),
        AppearanceResetRow(settings: settings),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}
