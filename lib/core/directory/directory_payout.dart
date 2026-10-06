import 'package:freezed_annotation/freezed_annotation.dart';

/// A dónde se le paga a alguien, tal como se muestra en *Pagar* (SPEC M4).
@immutable
final class DirectoryPayout {
  const new({
    required this.isClabe,
    required this.number,
    this.bankName,
    this.holderName,
  });

  /// CLABE (18 dígitos) o tarjeta (16).
  final bool isClabe;
  final String number;
  final String? bankName;
  final String? holderName;

  /// Agrupado para leerse: `0121 8000 0112 3456 71`.
  String get grouped => [
    for (var i = 0; i < number.length; i += 4)
      number.substring(i, i + 4 > number.length ? number.length : i + 4),
  ].join(' ');

  String get last4 => number.substring(number.length - 4);

  @override
  bool operator ==(Object other) =>
      other is DirectoryPayout &&
      other.isClabe == isClabe &&
      other.number == number &&
      other.bankName == bankName &&
      other.holderName == holderName;

  @override
  int get hashCode => Object.hash(isClabe, number, bankName, holderName);
}
