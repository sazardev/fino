import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/format/money_parser.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../domain/entities/debt.dart';
import '../../domain/enums/review_decision.dart';
import '../../domain/failures/order_failure.dart';
import '../../domain/failures/order_failure_reason.dart';
import '../providers/commands/cancel_debt_command_provider.dart';
import '../providers/commands/object_debt_command_provider.dart';
import '../providers/commands/retract_payment_command_provider.dart';
import '../providers/commands/review_debts_command_provider.dart';
import '../providers/commands/undo_confirmation_command_provider.dart';
import '../providers/commands/update_debt_amount_command_provider.dart';
import '../text/describe_order_error.dart';

/// Ejecuta las acciones sobre una deuda y le cuenta a la persona cómo salió.
class DebtActionRunner {
  const new(this._context, this._ref, this._debt);

  final BuildContext _context;
  final WidgetRef _ref;
  final Debt _debt;

  String get _me => _ref.read(sessionUserIdProvider)!;

  Future<bool> _run(Future<void> Function() action, String success) =>
      runAction(
        _context,
        action,
        success: success,
        describe: describeOrderError,
      );

  Future<bool> review(ReviewDecision decision, {String? note}) => _run(
    () => _ref.read(reviewDebtsCommandProvider)(
      actorId: _me,
      decisions: [(debtId: _debt.id, decision: decision, note: note)],
    ),
    decision == ReviewDecision.confirm ? 'Pago confirmado' : 'Pago rechazado',
  );

  Future<bool> cancel() => _run(
    () => _ref.read(cancelDebtCommandProvider)(actorId: _me, debtId: _debt.id),
    'Deuda cancelada',
  );

  Future<bool> undoConfirmation() => _run(
    () => _ref.read(undoConfirmationCommandProvider)(
      actorId: _me,
      debtId: _debt.id,
    ),
    'Confirmación deshecha',
  );

  Future<bool> retract() => _run(
    () => _ref.read(retractPaymentCommandProvider)(
      actorId: _me,
      paymentId: _debt.paymentId!,
      debtIds: [_debt.id],
    ),
    'Aviso de pago retirado',
  );

  Future<bool> object(String comment) => _run(
    () => _ref.read(objectDebtCommandProvider)(
      actorId: _me,
      debtId: _debt.id,
      comment: comment,
    ),
    'Objeción enviada',
  );

  Future<bool> updateAmount(String raw) => _run(() {
    final amount = MoneyParser.parse(raw);
    if (amount == null) {
      throw const OrderFailure(OrderFailureReason.amountNotPositive);
    }
    return _ref.read(updateDebtAmountCommandProvider)(
      actorId: _me,
      debtId: _debt.id,
      newAmount: amount,
    );
  }, 'Monto actualizado');
}
