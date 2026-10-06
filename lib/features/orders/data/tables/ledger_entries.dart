import 'package:drift/drift.dart';

import '../../../../core/database/converters/string_list_converter.dart';
import '../../domain/enums/ledger_event_type.dart';

/// Bitácora de pedidos (espejo local de `teams/{id}/ledger/{id}`).
@DataClassName('LedgerRow')
@TableIndex(name: 'ledger_order', columns: {#orderId, #at})
class LedgerEntries extends Table {
  TextColumn get id => text()();
  TextColumn get teamId => text()();
  TextColumn get orderId => text()();
  TextColumn get type => textEnum<LedgerEventType>()();
  TextColumn get actorId => text()();
  DateTimeColumn get at => dateTime()();
  TextColumn get debtId => text().nullable()();
  TextColumn get paymentId => text().nullable()();
  IntColumn get amountBeforeCents => integer().nullable()();
  IntColumn get amountAfterCents => integer().nullable()();
  TextColumn get note => text().nullable()();

  /// Quiénes pueden ver una línea confidencial (acreedor y deudor).
  TextColumn get partyIds => text().map(const StringListConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
