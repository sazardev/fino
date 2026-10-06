import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/app_button_tone.dart';
import '../../../../ui/molecules/inline_editor.dart';
import '../../domain/entities/debt.dart';
import '../../domain/entities/payment.dart';
import '../../domain/enums/review_decision.dart';
import '../providers/commands/retract_payment_command_provider.dart';
import '../providers/commands/review_debts_command_provider.dart';
import '../text/describe_order_error.dart';

/// Resolver un pago completo: el acreedor confirma o rechaza todo (G5); el
/// deudor puede retirarlo (G7).
class PaymentReviewActions extends ConsumerStatefulWidget {
  const new({required this.payment, required this.reported, super.key});

  final Payment payment;

  /// Las deudas del pago que siguen esperando confirmación.
  final List<Debt> reported;

  @override
  ConsumerState<PaymentReviewActions> createState() =>
      _PaymentReviewActionsState();
}

class _PaymentReviewActionsState extends ConsumerState<PaymentReviewActions> {
  var _rejecting = false;

  Future<bool> _review(ReviewDecision decision, {String? note}) => runAction(
    context,
    () => ref.read(reviewDebtsCommandProvider)(
      actorId: ref.read(sessionUserIdProvider)!,
      decisions: [
        for (final d in widget.reported)
          (debtId: d.id, decision: decision, note: note),
      ],
    ),
    success: decision == ReviewDecision.confirm
        ? 'Pago confirmado'
        : 'Pago rechazado',
    describe: describeOrderError,
  );

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(sessionUserIdProvider);
    final payment = widget.payment;
    if (widget.reported.isEmpty) return const SizedBox.shrink();

    if (me == payment.debtorId) {
      return AppButton(
        label: 'Retirar aviso de pago',
        icon: Icons.undo_rounded,
        tone: AppButtonTone.tonal,
        onPressed: () => runAction(
          context,
          () => ref.read(retractPaymentCommandProvider)(
            actorId: me!,
            paymentId: payment.id,
          ),
          success: 'Aviso retirado',
          describe: describeOrderError,
        ),
      );
    }
    if (me != payment.creditorId) return const SizedBox.shrink();
    if (_rejecting) {
      return InlineEditor(
        label: '¿Qué pasó? (opcional)',
        saveLabel: 'Rechazar pago',
        maxLength: 200,
        onSave: (note) async {
          if (await _review(ReviewDecision.reject, note: note) && mounted) {
            setState(() => _rejecting = false);
          }
        },
        onCancel: () => setState(() => _rejecting = false),
      );
    }
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        AppButton(
          label: 'Confirmar todo',
          icon: Icons.check_rounded,
          onPressed: () => _review(ReviewDecision.confirm),
        ),
        AppButton(
          label: 'No me llegó',
          icon: Icons.close_rounded,
          tone: AppButtonTone.tonal,
          onPressed: () => setState(() => _rejecting = true),
        ),
      ],
    );
  }
}
