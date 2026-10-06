import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/format/money_parser.dart';
import '../../../../ui/molecules/inline_editor.dart';
import '../../domain/entities/debt.dart';
import '../../domain/enums/review_decision.dart';
import '../providers/debt_action.dart';
import 'debt_action_runner.dart';

/// Lo que se captura en el lugar antes de rechazar, objetar o cambiar un
/// monto (no hay diálogos, DESIGN §1.5).
class DebtEditor extends ConsumerWidget {
  const new({
    required this.debt,
    required this.action,
    required this.onClose,
    super.key,
  });

  final Debt debt;
  final DebtAction action;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runner = DebtActionRunner(context, ref, debt);
    Future<void> then(Future<bool> done) async {
      if (await done) onClose();
    }

    return switch (action) {
      DebtAction.reject => InlineEditor(
        label: '¿Qué pasó? (opcional)',
        hint: 'No me llegó la transferencia',
        saveLabel: 'Rechazar pago',
        maxLength: 200,
        onSave: (note) =>
            then(runner.review(ReviewDecision.reject, note: note)),
        onCancel: onClose,
      ),
      DebtAction.object => InlineEditor(
        label: '¿Qué está mal?',
        hint: 'Yo no estuve, el monto no es…',
        saveLabel: 'Enviar objeción',
        maxLength: 200,
        onSave: (comment) => then(runner.object(comment)),
        onCancel: onClose,
      ),
      _ => InlineEditor(
        label: 'Nuevo monto',
        saveLabel: 'Guardar monto',
        prefixText: r'$ ',
        initial: MoneyParser.editable(debt.amount),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onSave: (raw) => then(runner.updateAmount(raw)),
        onCancel: onClose,
      ),
    };
  }
}
