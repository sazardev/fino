import 'package:drift/drift.dart';

import '../payout_method_type.dart';

/// Métodos de cobro que este usuario puede ver: el suyo y los de quienes
/// le dieron acceso por una deuda viva (SPEC M4).
@DataClassName('PayoutMethodRow')
class PayoutMethods extends Table {
  TextColumn get teamId => text()();
  TextColumn get userId => text()();
  TextColumn get type => textEnum<PayoutMethodType>()();
  TextColumn get number => text()();
  TextColumn get bankName => text().nullable()();
  TextColumn get holderName => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {teamId, userId};
}
