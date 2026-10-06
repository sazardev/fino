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
import 'order_text.dart';

/// El deudor objeta su deuda con un comentario (SPEC D5).
///
/// No cambia el estado: solo le avisa al acreedor para que corrija o cancele.
class ObjectDebt {
  const new(this._newId);

  final IdGenerator _newId;

  OrderChangeSet call({
    required String actorId,
    required Debt debt,
    required Order order,
    required String comment,
    required DateTime now,
  }) {
    OrderGuards.requireDebtor(actorId, debt.debtorId);
    if (debt.status != DebtStatus.pending) {
      throw const OrderFailure(OrderFailureReason.invalidTransition);
    }

    final text = OrderText.comment(comment);
    return OrderChangeSet(
      ledger: [
        LedgerRecorder(_newId).record(
          orderId: debt.orderId,
          type: LedgerEventType.debtObjected,
          actorId: actorId,
          at: now,
          debtId: debt.id,
          note: text,
        ),
      ],
      notifications: [
        NotificationIntent(
          kind: NotificationKind.debtObjected,
          recipientId: debt.creditorId,
          actorId: actorId,
          teamId: debt.teamId,
          target: NotificationTarget.debt(debt.id),
          concept: order.concept,
          note: text,
        ),
      ],
    );
  }
}
