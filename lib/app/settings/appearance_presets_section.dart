import 'dart:async';

import 'package:flutter/material.dart';

import '../../ui/atoms/theme_preview.dart';
import '../../ui/design/app_spacing.dart';
import '../../ui/molecules/collapsible_section.dart';
import '../../ui/organisms/preset_picker.dart';
import 'app_settings.dart';
import 'appearance_preset.dart';

/// Ready-made looks (theme + color), each drawn as a miniature of the app in
/// that look, at the user's current interface size.
class AppearancePresetsSection extends StatelessWidget {
  const new({required this.settings, super.key});

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return ListenableBuilder(
      listenable: settings.appearance,
      builder: (context, _) {
        final current = AppearancePreset.matching(
          settings.themeMode.value,
          settings.accent.value,
        );

        return CollapsibleSection(
          icon: Icons.auto_awesome_rounded,
          title: 'Estilo rápido',
          summary: Text(current?.label ?? 'Personalizado'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xs,
                  0,
                  AppSpacing.xs,
                  AppSpacing.md,
                ),
                child: Text(
                  'Un toque cambia el tema y el color. El tamaño no se toca.',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: muted),
                ),
              ),
              PresetPicker<AppearancePreset>(
                items: [
                  for (final p in AppearancePreset.all) (p, p.label, p.hint),
                ],
                selected: current,
                previewBuilder: (p) => ThemePreview(
                  mode: p.themeMode,
                  accent: p.accent,
                  uiSize: settings.uiSize.value,
                ),
                onChanged: (p) {
                  unawaited(settings.themeMode.update(p.themeMode));
                  unawaited(settings.accent.update(p.accent));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
