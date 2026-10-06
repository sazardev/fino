import 'package:freezed_annotation/freezed_annotation.dart';

import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';
import 'payout_method.dart';

/// Tarjeta de 16 dígitos más banco (M1).
@immutable
final class CardPayout extends PayoutMethod {
  const new _internal(this.cardNumber, this.bankName, {super.holderName});

  /// Acepta espacios o guiones; lanza `invalidCard` o `bankRequired`.
  factory parse(String raw, {required String bankName, String? holderName}) {
    final digits = raw.replaceAll(RegExp(r'[\s-]'), '');
    if (!RegExp(r'^\d{16}$').hasMatch(digits)) {
      throw const TeamFailure(TeamFailureReason.invalidCard);
    }
    final bank = bankName.trim();
    if (bank.isEmpty) {
      throw const TeamFailure(TeamFailureReason.bankRequired);
    }
    return CardPayout._internal(digits, bank, holderName: holderName);
  }

  final String cardNumber;

  @override
  final String bankName;

  @override
  String get last4 => cardNumber.substring(cardNumber.length - 4);

  @override
  bool operator ==(Object other) =>
      other is CardPayout &&
      other.cardNumber == cardNumber &&
      other.bankName == bankName &&
      other.holderName == holderName;

  @override
  int get hashCode => Object.hash(cardNumber, bankName, holderName);
}
