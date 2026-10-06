import 'package:freezed_annotation/freezed_annotation.dart';

/// Qué cuenta se le mostró al deudor al reportar su pago (SPEC M5).
@immutable
final class PayoutSnapshot {
  const new({required this.last4, this.bankName});

  final String? bankName;
  final String last4;

  @override
  bool operator ==(Object other) =>
      other is PayoutSnapshot &&
      other.bankName == bankName &&
      other.last4 == last4;

  @override
  int get hashCode => Object.hash(bankName, last4);

  @override
  String toString() => 'PayoutSnapshot($bankName, $last4)';
}
