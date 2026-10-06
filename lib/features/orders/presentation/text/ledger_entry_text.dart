import '../../../../core/format/money_format.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/enums/ledger_event_type.dart';

/// Una línea de la bitácora contada en una frase (SPEC §11).
abstract final class LedgerEntryText {
  /// [actor] y [debtor] ya vienen nombrados ("Tú", "Ana"…).
  static String of(LedgerEntry entry, {required String actor, String? debtor}) {
    final who = debtor ?? 'alguien';
    final before = entry.amountBefore;
    final after = entry.amountAfter;
    final amount = after == null ? '' : ' (${MoneyFormat.format(after)})';
    final change = before != null && after != null
        ? ': ${MoneyFormat.format(before)} → ${MoneyFormat.format(after)}'
        : '';
    final note = entry.note == null ? '' : ' · ${entry.note}';
    return switch (entry.type) {
      LedgerEventType.orderCreated => '$actor registró el pedido$amount',
      LedgerEventType.orderDetailsEdited => '$actor editó los detalles',
      LedgerEventType.orderTotalChanged => '$actor cambió el total$change',
      LedgerEventType.orderRedistributed => '$actor repartió de nuevo',
      LedgerEventType.orderCancelled => '$actor canceló el pedido$note',
      LedgerEventType.debtAdded => '$actor agregó a $who$amount',
      LedgerEventType.debtAmountChanged => 'El monto de $who cambió$change',
      LedgerEventType.debtCancelled => '$actor canceló lo de $who$note',
      LedgerEventType.paymentReported => '$actor avisó que pagó$note',
      LedgerEventType.paymentRetracted => '$actor retiró su aviso de pago',
      LedgerEventType.paymentConfirmed => '$actor confirmó el pago de $who',
      LedgerEventType.paymentRejected =>
        '$actor no recibió el pago de $who$note',
      LedgerEventType.confirmationUndone =>
        '$actor deshizo la confirmación de $who',
      LedgerEventType.debtObjected => '$actor objetó su deuda$note',
    };
  }
}
