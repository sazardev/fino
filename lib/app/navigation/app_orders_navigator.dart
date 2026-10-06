import '../../features/orders/presentation/navigation/orders_navigator.dart';
import '../router/app_routes.dart';
import 'router_opener.dart';

/// [OrdersNavigator] con las rutas de la app.
class AppOrdersNavigator implements OrdersNavigator {
  const new(this._open);

  final RouterOpener _open;

  @override
  void openOrder(String orderId) =>
      _open.open(OrderDetailRoute(orderId: orderId).location);

  @override
  void openCounterpart(String teamId, String userId) =>
      _open.open(CounterpartRoute(teamId: teamId, userId: userId).location);

  @override
  void openPay(String teamId, String creditorId) =>
      _open.push(PayRoute(teamId: teamId, creditorId: creditorId).location);

  @override
  void openPayment(String paymentId) =>
      _open.open(PaymentRoute(paymentId: paymentId).location);

  @override
  void openNewOrder() => _open.push(const NewOrderRoute().location);

  @override
  void showCreatedOrder(String orderId) =>
      _open.go(OrderDetailRoute(orderId: orderId).location);

  @override
  void openEditOrder(String orderId) =>
      _open.push(EditOrderRoute(orderId: orderId).location);

  @override
  void openAddDebtor(String orderId) =>
      _open.push(AddDebtorRoute(orderId: orderId).location);

  @override
  void openNotice(String teamId, List<String> recipientIds) => _open.push(
    NoticeRoute(teamId: teamId, para: recipientIds.join(',')).location,
  );

  @override
  void openPayoutSetup(String teamId) =>
      _open.push(PayoutSetupRoute(teamId: teamId).location);

  @override
  void openCreateTeam() => _open.push(const CreateTeamRoute().location);

  @override
  void openJoinTeam() => _open.push(const JoinTeamRoute().location);
}
