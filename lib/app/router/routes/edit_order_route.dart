part of '../app_routes.dart';

/// "Editar pedido": pantalla completa.
@TypedGoRoute<EditOrderRoute>(path: '/editar-pedido/:orderId')
class EditOrderRoute extends GoRouteData with $EditOrderRoute {
  const new({required this.orderId});

  final String orderId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: EditOrderPage(
          orderId: orderId,
          onBack: BackNavigation.to(
            context,
            fallback: OrderDetailRoute(orderId: orderId).location,
          ),
        ),
      );
}
