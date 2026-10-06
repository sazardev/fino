import 'debt_status.dart';

/// Estado derivado de un pedido (SPEC §5.4); nunca se edita a mano.
enum OrderStatus {
  /// Tiene al menos una deuda viva.
  open,

  /// Sin deudas vivas y con al menos una confirmada.
  settled,

  /// Todas sus deudas están canceladas.
  cancelled;

  static OrderStatus fromDebts(Iterable<DebtStatus> statuses) {
    if (statuses.any((status) => status.isLive)) return open;
    if (statuses.any((status) => status == DebtStatus.confirmed)) {
      return settled;
    }
    return cancelled;
  }
}
