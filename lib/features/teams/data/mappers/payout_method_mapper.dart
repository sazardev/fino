import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/card_payout.dart';
import '../../domain/entities/clabe_payout.dart';
import '../../domain/entities/payout_method.dart';
import '../payout_method_type.dart';

/// Fila local ↔ [PayoutMethod].
abstract final class PayoutMethodMapper {
  static PayoutMethod toDomain(PayoutMethodRow row) => switch (row.type) {
    PayoutMethodType.clabe => ClabePayout.parse(
      row.number,
      bankName: row.bankName,
      holderName: row.holderName,
    ),
    PayoutMethodType.card => CardPayout.parse(
      row.number,
      bankName: row.bankName ?? '',
      holderName: row.holderName,
    ),
  };

  static PayoutMethodsCompanion toCompanion(
    PayoutMethod method, {
    required String teamId,
    required String userId,
  }) => PayoutMethodsCompanion.insert(
    teamId: teamId,
    userId: userId,
    type: switch (method) {
      ClabePayout() => PayoutMethodType.clabe,
      CardPayout() => PayoutMethodType.card,
      _ => throw ArgumentError('Unknown payout method: $method'),
    },
    number: switch (method) {
      ClabePayout(:final clabe) => clabe,
      CardPayout(:final cardNumber) => cardNumber,
      _ => throw ArgumentError('Unknown payout method: $method'),
    },
    bankName: Value(method.bankName),
    holderName: Value(method.holderName),
  );
}
