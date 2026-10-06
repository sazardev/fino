import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/ledger_entry.dart';

/// Fila local ↔ [LedgerEntry].
abstract final class LedgerEntryMapper {
  static LedgerEntry toDomain(LedgerRow row) => LedgerEntry(
    id: row.id,
    orderId: row.orderId,
    type: row.type,
    actorId: row.actorId,
    at: row.at.toUtc(),
    debtId: row.debtId,
    paymentId: row.paymentId,
    amountBefore: _money(row.amountBeforeCents),
    amountAfter: _money(row.amountAfterCents),
    note: row.note,
  );

  /// [teamId] y [partyIds] (acreedor y deudor, para las líneas
  /// confidenciales) no viajan en la entidad: los pone quien la guarda.
  static LedgerEntriesCompanion toCompanion(
    LedgerEntry entry, {
    required String teamId,
    required List<String> partyIds,
  }) => LedgerEntriesCompanion.insert(
    id: entry.id,
    teamId: teamId,
    orderId: entry.orderId,
    type: entry.type,
    actorId: entry.actorId,
    at: entry.at,
    debtId: Value(entry.debtId),
    paymentId: Value(entry.paymentId),
    amountBeforeCents: Value(entry.amountBefore?.cents),
    amountAfterCents: Value(entry.amountAfter?.cents),
    note: Value(entry.note),
    partyIds: partyIds,
  );

  static Money? _money(int? cents) => cents == null ? null : Money(cents);
}
