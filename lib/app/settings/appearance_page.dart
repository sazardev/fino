import 'package:flutter/material.dart';

import '../../ui/design/app_spacing.dart';
import '../../ui/molecules/section_header.dart';
import '../../ui/molecules/theme_mode_selector.dart';
import '../../ui/molecules/ui_size_selector.dart';
import '../../ui/organisms/accent_picker.dart';
import '../../ui/responsive/ui_size.dart';
import '../../ui/templates/settings_shell.dart';
import '../../ui/theme/accent_palette.dart';
import 'settings_scope.dart';

/// Theme mode, accent color and interface size. Every choice applies live.
class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.of(context);

    return SettingsShell(
      children: [
        const SectionHeader('Tema'),
        ValueListenableBuilder<ThemeMode>(
          valueListenable: settings.themeMode,
          builder: (context, mode, _) => ThemeModeSelector(
            mode: mode,
            onChanged: settings.themeMode.update,
          ),
        ),
        const SectionHeader('Color de acento'),
        ValueListenableBuilder<Color>(
          valueListenable: settings.accent,
          builder: (context, color, _) => AccentPicker(
            colors: AccentPalette.colors,
            color: color,
            onChanged: settings.accent.update,
          ),
        ),
        const SectionHeader('Tamaño de la interfaz'),
        ValueListenableBuilder<UiSize>(
          valueListenable: settings.uiSize,
          builder: (context, size, _) =>
              UiSizeSelector(size: size, onChanged: settings.uiSize.update),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}
