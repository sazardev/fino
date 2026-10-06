import '../../core/notifications/intent/notification_intent.dart';
import '../../core/notifications/intent/notification_target_type.dart';
import '../../features/inbox/presentation/navigation/inbox_navigator.dart';
import '../../features/orders/domain/orders_repository.dart';
import '../router/app_routes.dart';
import 'router_opener.dart';

/// Lleva cada notificación a lo que cambió (SPEC N3). Una deuda se muestra
/// dentro de su pedido; si ya no existe, se abre la lista de pedidos.
class AppInboxNavigator implements InboxNavigator {
  const new(this._open, this._orders);

  final RouterOpener _open;
  final OrdersRepository _orders;

  @override
  Future<void> openTarget(NotificationIntent intent) async {
    final id = intent.target.id;
    final location = switch (intent.target.type) {
      NotificationTargetType.debt => await _debtLocation(id),
      NotificationTargetType.payment => PaymentRoute(paymentId: id).location,
      NotificationTargetType.pay => PayRoute(
        teamId: intent.teamId,
        creditorId: id,
      ).location,
      NotificationTargetType.history => const OrdersRoute().location,
      NotificationTargetType.team => TeamDetailRoute(teamId: id).location,
    };
    _open.open(location);
  }

  Future<String> _debtLocation(String debtId) async {
    final debts = await _orders.findDebts([debtId]);
    return debts.isEmpty
        ? const OrdersRoute().location
        : OrderDetailRoute(orderId: debts.single.orderId).location;
  }
}
