import '../../domain/entities/card_payout.dart';
import '../../domain/entities/clabe_payout.dart';
import '../../domain/entities/payout_method.dart';
import '../payout_method_type.dart';

/// [PayoutMethod] ↔ `teams/{team}/members/{uid}/payout/main` (SPEC M4).
abstract final class PayoutMethodRemoteMapper {
  static const documentId = 'main';

  static String collection(String teamId, String userId) =>
      'teams/$teamId/members/$userId/payout';

  static Map<String, Object?> toFields(PayoutMethod method) => switch (method) {
    ClabePayout(:final clabe) => {
      'type': PayoutMethodType.clabe.name,
      'number': clabe,
      'bankName': ?method.bankName,
      'holderName': ?method.holderName,
    },
    CardPayout(:final cardNumber, :final bankName) => {
      'type': PayoutMethodType.card.name,
      'number': cardNumber,
      'bankName': bankName,
      'holderName': ?method.holderName,
    },
    _ => throw ArgumentError('Unknown payout method: $method'),
  };

  static PayoutMethod fromFields(Map<String, Object?> fields) {
    final bank = fields['bankName'] as String?;
    final holder = fields['holderName'] as String?;
    return switch (PayoutMethodType.values.byName(fields['type']! as String)) {
      PayoutMethodType.clabe => ClabePayout.parse(
        fields['number']! as String,
        bankName: bank,
        holderName: holder,
      ),
      PayoutMethodType.card => CardPayout.parse(
        fields['number']! as String,
        bankName: bank ?? '',
        holderName: holder,
      ),
    };
  }
}
