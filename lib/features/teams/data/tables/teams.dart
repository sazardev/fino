import 'package:drift/drift.dart';

/// Equipos a los que pertenece el usuario (espejo local de `teams/{id}`).
@DataClassName('TeamRow')
class Teams extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get adminId => text()();
  TextColumn get inviteCode => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
