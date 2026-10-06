import 'package:flutter/material.dart';

import '../../ui/atoms/app_switch.dart';
import '../../ui/design/app_spacing.dart';
import '../../ui/molecules/collapsible_section.dart';
import '../../ui/molecules/settings_row.dart';
import '../../ui/molecules/ui_size_selector.dart';
import 'app_settings.dart';
import 'appearance_labels.dart';

/// Interface size, kept exactly as chosen on every screen, plus the opt-in to
/// let tablets, desktops and the web grow it further.
class AppearanceSizeSection extends StatelessWidget {
  const new({required this.settings, super.key});

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return ListenableBuilder(
      listenable: settings.appearance,
      builder: (context, _) {
        final size = settings.uiSize.value;
        final adapt = settings.adaptToScreen.value;

        return CollapsibleSection(
          icon: Icons.format_size_rounded,
          title: 'Tamaño de la interfaz',
          initiallyExpanded: false,
          summary: Text(
            adapt ? '${uiSizeLabel(size)} · Adaptable' : uiSizeLabel(size),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UiSizeSelector(size: size, onChanged: settings.uiSize.update),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${uiSizeHint(size)} Es el mismo en móvil, tablet y web.',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: muted),
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsRow(
                label: 'Ampliar en pantallas grandes',
                subtitle:
                    'Agranda la interfaz según la pantalla, hasta un '
                    '50 %. Apagado, el tamaño es siempre el que elegiste.',
                trailing: AppSwitch(
                  value: adapt,
                  onChanged: settings.adaptToScreen.update,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
