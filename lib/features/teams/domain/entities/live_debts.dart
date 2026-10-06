import 'package:freezed_annotation/freezed_annotation.dart';

/// Deudas vivas (pendientes o con pago reportado) de un usuario o equipo.
///
/// Las calcula la capa de datos desde los pedidos; aquí solo se usan para
/// bloquear salir, expulsar o eliminar (SPEC §4.2).
@immutable
final class LiveDebts {
  const new({this.asDebtor = 0, this.asCreditor = 0});

  static const none = LiveDebts();

  final int asDebtor;
  final int asCreditor;

  bool get hasAny => asDebtor > 0 || asCreditor > 0;

  @override
  bool operator ==(Object other) =>
      other is LiveDebts &&
      other.asDebtor == asDebtor &&
      other.asCreditor == asCreditor;

  @override
  int get hashCode => Object.hash(asDebtor, asCreditor);
}
