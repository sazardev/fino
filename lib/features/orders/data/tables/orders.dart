import 'package:drift/drift.dart';

/// Pedidos del equipo (espejo local de `teams/{id}/orders/{id}`).
@DataClassName('OrderRow')
@TableIndex(name: 'orders_team', columns: {#teamId, #spentAt})
class Orders extends Table {
  TextColumn get id => text()();
  TextColumn get teamId => text()();
  TextColumn get creditorId => text()();
  TextColumn get concept => text()();
  TextColumn get note => text().nullable()();
  IntColumn get totalCents => integer()();
  DateTimeColumn get spentAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
