import 'package:drift/drift.dart';

import '../../../../core/database/converters/string_list_converter.dart';

/// Pagos agrupados (espejo local de `teams/{id}/payments/{id}`).
@DataClassName('PaymentRow')
@TableIndex(name: 'payments_team', columns: {#teamId})
class Payments extends Table {
  TextColumn get id => text()();
  TextColumn get teamId => text()();
  TextColumn get creditorId => text()();
  TextColumn get debtorId => text()();
  TextColumn get debtIds => text().map(const StringListConverter())();
  TextColumn get payoutBankName => text().nullable()();
  TextColumn get payoutLast4 => text()();
  TextColumn get reference => text().nullable()();
  DateTimeColumn get reportedAt => dateTime()();
  BoolColumn get awaitingConfirmationReminderSent =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
