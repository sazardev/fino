import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../entities/ledger_entry.dart';
import '../enums/ledger_event_type.dart';

/// Construye líneas de bitácora con identificador propio.
class LedgerRecorder {
  const new(this._newId);

  final IdGenerator _newId;

  LedgerEntry record({
    required String orderId,
    required LedgerEventType type,
    required String actorId,
    required DateTime at,
    String? debtId,
    String? paymentId,
    Money? amountBefore,
    Money? amountAfter,
    String? note,
  }) => LedgerEntry(
    id: _newId(),
    orderId: orderId,
    type: type,
    actorId: actorId,
    at: at,
    debtId: debtId,
    paymentId: paymentId,
    amountBefore: amountBefore,
    amountAfter: amountAfter,
    note: note,
  );
}
