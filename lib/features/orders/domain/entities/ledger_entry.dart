import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/money/money.dart';
import '../enums/ledger_event_type.dart';

part 'ledger_entry.freezed.dart';

/// Una línea inmutable de la bitácora de un pedido (SPEC §11).
@freezed
abstract class LedgerEntry with _$LedgerEntry {
  const factory({
    required String id,
    required String orderId,
    required LedgerEventType type,
    required String actorId,
    required DateTime at,
    String? debtId,
    String? paymentId,
    Money? amountBefore,
    Money? amountAfter,
    String? note,
  }) = _LedgerEntry;
}
