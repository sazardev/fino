part of '../app_routes.dart';

class OrdersRoute extends GoRouteData with $OrdersRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: OrdersPage());
}
