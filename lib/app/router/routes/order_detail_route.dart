part of '../app_routes.dart';

/// Un pedido (dentro de Pedidos).
class OrderDetailRoute extends GoRouteData with $OrderDetailRoute {
  const new({required this.orderId});

  final String orderId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: OrderDetailPage(
          orderId: orderId,
          onBack: BackNavigation.to(
            context,
            fallback: const OrdersRoute().location,
          ),
        ),
      );
}
