import '../../../../core/ids/id_generator.dart';
import '../entities/order.dart';
import '../entities/order_change_set.dart';
import '../enums/ledger_event_type.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';
import 'order_text.dart';

/// Edita concepto, nota y fecha: siempre permitido y sin notificar (§5.5).
class EditOrderDetails {
  const new(this._newId);

  final IdGenerator _newId;

  OrderChangeSet call({
    required String actorId,
    required Order order,
    required String concept,
    required DateTime spentAt,
    required DateTime now,
    String? note,
  }) {
    OrderGuards.requireCreditor(actorId, order.creditorId);
    final edited = order.copyWith(
      concept: OrderText.concept(concept),
      note: OrderText.note(note),
      spentAt: spentAt,
      updatedAt: now,
    );
    if (edited == order.copyWith(updatedAt: now)) return OrderChangeSet.empty;

    return OrderChangeSet(
      order: edited,
      ledger: [
        LedgerRecorder(_newId).record(
          orderId: order.id,
          type: LedgerEventType.orderDetailsEdited,
          actorId: actorId,
          at: now,
        ),
      ],
    );
  }
}
