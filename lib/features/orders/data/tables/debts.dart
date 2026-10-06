import 'package:drift/drift.dart';

import '../../domain/enums/debt_status.dart';

/// Deudas del equipo (espejo local de `teams/{id}/debts/{id}`).
@DataClassName('DebtRow')
@TableIndex(name: 'debts_order', columns: {#orderId})
@TableIndex(name: 'debts_team_status', columns: {#teamId, #status})
@TableIndex(name: 'debts_debtor_status', columns: {#debtorId, #status})
@TableIndex(name: 'debts_creditor_status', columns: {#creditorId, #status})
@TableIndex(name: 'debts_payment', columns: {#paymentId})
class Debts extends Table {
  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get teamId => text()();
  TextColumn get creditorId => text()();
  TextColumn get debtorId => text()();
  IntColumn get amountCents => integer()();
  TextColumn get status => textEnum<DebtStatus>()();
  TextColumn get paymentId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
