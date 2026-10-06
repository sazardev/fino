import 'package:flutter/material.dart';

import '../../../ui/molecules/confirm_action_row.dart';
import '../../../ui/molecules/empty_state.dart';
import '../../../ui/molecules/section_header.dart';

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader('Confirmación en sitio'),
        ConfirmActionRow(
          icon: Icons.delete_rounded,
          label: 'Borrar ejemplo',
          confirmLabel: 'Confirmar: borrar ejemplo',
          hint: 'No se puede deshacer',
          onConfirmed: () =>
              Future<void>.delayed(const Duration(milliseconds: 800)),
        ),
        const SectionHeader('Estado vacío'),
        const EmptyState(
          icon: Icons.inbox_rounded,
          title: 'Nada por aquí',
          hint: 'Cuando haya algo, aparecerá aquí',
        ),
      ],
    );
  }
}
