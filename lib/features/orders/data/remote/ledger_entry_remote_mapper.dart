import '../../../../core/money/money.dart';
import '../../../../core/sync/remote_marker.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/enums/ledger_event_type.dart';

/// [LedgerEntry] ↔ documento `teams/{team}/ledger/{id}`.
abstract final class LedgerEntryRemoteMapper {
  static String collection(String teamId) => 'teams/$teamId/ledger';

  /// [partyIds] (acreedor y deudor) deciden quién ve las líneas
  /// confidenciales; en las demás va vacío.
  static Map<String, Object?> toCreateFields(
    LedgerEntry entry, {
    required List<String> partyIds,
  }) => {
    'orderId': entry.orderId,
    'type': entry.type.name,
    'actorId': entry.actorId,
    'at': RemoteMarker.serverTimestamp,
    'debtId': ?entry.debtId,
    'paymentId': ?entry.paymentId,
    'amountBefore': ?entry.amountBefore?.cents,
    'amountAfter': ?entry.amountAfter?.cents,
    'note': ?entry.note,
    'confidential': entry.type.confidential,
    'partyIds': partyIds,
  };

  static LedgerEntry fromFields(String id, Map<String, Object?> fields) =>
      LedgerEntry(
        id: id,
        orderId: fields['orderId']! as String,
        type: LedgerEventType.values.byName(fields['type']! as String),
        actorId: fields['actorId']! as String,
        at: fields['at']! as DateTime,
        debtId: fields['debtId'] as String?,
        paymentId: fields['paymentId'] as String?,
        amountBefore: _money(fields['amountBefore']),
        amountAfter: _money(fields['amountAfter']),
        note: fields['note'] as String?,
      );

  static Money? _money(Object? cents) => cents is int ? Money(cents) : null;
}
