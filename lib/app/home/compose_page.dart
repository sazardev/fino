import 'package:flutter/material.dart';

import '../../ui/molecules/empty_state.dart';
import '../../ui/templates/settings_shell.dart';

/// Placeholder full-screen form. Its title earns its place: it says what the
/// screen is for, which no navigation label does here.
class ComposePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsShell(
      title: 'Nuevo movimiento',
      children: [
        EmptyState(
          icon: Icons.edit_note_rounded,
          title: 'Aquí irá el formulario',
        ),
      ],
    );
  }
}
