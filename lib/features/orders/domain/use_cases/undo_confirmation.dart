import '../../../../core/ids/id_generator.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/debt.dart';
import '../entities/order.dart';
import '../entities/order_change_set.dart';
import '../enums/debt_status.dart';
import '../enums/ledger_event_type.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';

/// El acreedor deshace una confirmación equivocada (SPEC D4).
///
/// La deuda vuelve a "pago reportado": el acreedor decide de nuevo.
class UndoConfirmation {
  const new(this._newId);

  final IdGenerator _newId;

  /// Si ya está "por confirmar" no hace nada. Requiere que el deudor siga
  /// en el equipo ([debtorIsMember]).
  OrderChangeSet call({
    required String actorId,
    required Debt debt,
    required Order order,
    required bool debtorIsMember,
    required DateTime now,
  }) {
    OrderGuards.requireCreditor(actorId, debt.creditorId);
    if (debt.status == DebtStatus.paymentReported) return OrderChangeSet.empty;
    if (debt.status != DebtStatus.confirmed) {
      throw const OrderFailure(OrderFailureReason.invalidTransition);
    }
    if (!debtorIsMember) {
      throw const OrderFailure(OrderFailureReason.debtorLeftTeam);
    }

    final undone = debt.copyWith(
      status: DebtStatus.paymentReported,
      updatedAt: now,
    );
    return OrderChangeSet(
      debts: [undone],
      ledger: [
        LedgerRecorder(_newId).record(
          orderId: debt.orderId,
          type: LedgerEventType.confirmationUndone,
          actorId: actorId,
          at: now,
          debtId: debt.id,
          paymentId: debt.paymentId,
        ),
      ],
      notifications: [
        NotificationIntent(
          kind: NotificationKind.confirmationUndone,
          recipientId: debt.debtorId,
          actorId: actorId,
          teamId: debt.teamId,
          target: NotificationTarget.debt(debt.id),
          amount: debt.amount,
          concept: order.concept,
        ),
      ],
    );
  }
}
