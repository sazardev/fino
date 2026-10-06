import 'package:flutter/material.dart';

import '../../ui/molecules/empty_state.dart';
import '../../ui/templates/settings_shell.dart';

/// Placeholder full-screen form. Its title earns its place: it says what the
/// screen is for, which no navigation label does here.
class ComposePage extends StatelessWidget {
  const new({super.key, this.onBack});

  /// Where the back button leads; set by the route.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SettingsShell(
      title: 'Nuevo movimiento',
      onBack: onBack,
      children: const [
        EmptyState(
          icon: Icons.edit_note_rounded,
          title: 'Aquí irá el formulario',
        ),
      ],
    );
  }
}
