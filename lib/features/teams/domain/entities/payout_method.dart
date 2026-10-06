import 'package:freezed_annotation/freezed_annotation.dart';

/// Dónde le pagan a un miembro: CLABE o tarjeta + banco (SPEC M1).
@immutable
abstract class PayoutMethod {
  const new({this.holderName});

  /// Titular (opcional).
  final String? holderName;

  /// Banco, si se conoce (obligatorio en tarjeta).
  String? get bankName;

  /// Últimos 4 dígitos: lo único que queda en el aviso de pago (M5).
  String get last4;
}
