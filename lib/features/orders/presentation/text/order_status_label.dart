import '../../domain/enums/order_status.dart';

abstract final class OrderStatusLabel {
  static String of(OrderStatus status) => switch (status) {
    OrderStatus.open => 'Abierto',
    OrderStatus.settled => 'Saldado',
    OrderStatus.cancelled => 'Cancelado',
  };
}
