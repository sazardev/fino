import 'package:freezed_annotation/freezed_annotation.dart';

import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';
import 'payout_method.dart';

/// CLABE interbancaria de 18 dígitos con dígito verificador válido (M3).
@immutable
final class ClabePayout extends PayoutMethod {
  const new _internal(this.clabe, {this.bankName, super.holderName});

  /// Acepta espacios o guiones; lanza `invalidClabe` si no cumple.
  factory parse(String raw, {String? bankName, String? holderName}) {
    final digits = raw.replaceAll(RegExp(r'[\s-]'), '');
    if (!_isValid(digits)) {
      throw const TeamFailure(TeamFailureReason.invalidClabe);
    }
    return ClabePayout._internal(
      digits,
      bankName: bankName,
      holderName: holderName,
    );
  }

  final String clabe;

  @override
  final String? bankName;

  @override
  String get last4 => clabe.substring(clabe.length - 4);

  static bool _isValid(String digits) {
    if (!RegExp(r'^\d{18}$').hasMatch(digits)) return false;
    const weights = [3, 7, 1];
    var sum = 0;
    for (var i = 0; i < 17; i++) {
      sum += (int.parse(digits[i]) * weights[i % 3]) % 10;
    }
    return (10 - sum % 10) % 10 == int.parse(digits[17]);
  }

  @override
  bool operator ==(Object other) =>
      other is ClabePayout &&
      other.clabe == clabe &&
      other.bankName == bankName &&
      other.holderName == holderName;

  @override
  int get hashCode => Object.hash(clabe, bankName, holderName);
}
