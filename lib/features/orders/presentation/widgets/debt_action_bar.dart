import 'package:flutter/material.dart';

import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/app_button_tone.dart';
import '../providers/debt_action.dart';

/// Los botones de las acciones disponibles sobre una deuda.
class DebtActionBar extends StatelessWidget {
  const new({required this.actions, required this.onAction, super.key});

  final List<DebtAction> actions;
  final ValueChanged<DebtAction> onAction;

  static (String, IconData, AppButtonTone) _look(DebtAction action) =>
      switch (action) {
        DebtAction.confirm => (
          'Confirmar',
          Icons.check_rounded,
          AppButtonTone.primary,
        ),
        DebtAction.reject => (
          'No me llegó',
          Icons.close_rounded,
          AppButtonTone.tonal,
        ),
        DebtAction.editAmount => (
          'Cambiar monto',
          Icons.edit_rounded,
          AppButtonTone.tonal,
        ),
        DebtAction.cancel => (
          'Cancelar',
          Icons.block_rounded,
          AppButtonTone.danger,
        ),
        DebtAction.undoConfirmation => (
          'Deshacer',
          Icons.undo_rounded,
          AppButtonTone.tonal,
        ),
        DebtAction.pay => (
          'Pagar',
          Icons.payments_rounded,
          AppButtonTone.primary,
        ),
        DebtAction.object => (
          'Objetar',
          Icons.feedback_rounded,
          AppButtonTone.tonal,
        ),
        DebtAction.retract => (
          'Retirar aviso',
          Icons.undo_rounded,
          AppButtonTone.tonal,
        ),
      };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final action in actions)
          Builder(
            builder: (context) {
              final (label, icon, tone) = _look(action);
              return AppButton(
                label: label,
                icon: icon,
                tone: tone,
                onPressed: () => onAction(action),
              );
            },
          ),
      ],
    );
  }
}
