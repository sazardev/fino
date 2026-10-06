import 'package:flutter/material.dart';

import '../../ui/molecules/confirm_action_row.dart';
import 'app_settings.dart';

/// Back to the original theme, color and size, confirmed in place.
class AppearanceResetRow extends StatelessWidget {
  const new({required this.settings, super.key});

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    return ConfirmActionRow(
      icon: Icons.restart_alt_rounded,
      label: 'Restablecer apariencia',
      confirmLabel: 'Confirmar: restablecer',
      hint: 'Vuelve al tema, color y tamaño originales.',
      onConfirmed: settings.resetAppearance,
    );
  }
}
