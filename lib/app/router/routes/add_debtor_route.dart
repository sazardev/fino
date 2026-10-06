part of '../app_routes.dart';

/// "Agregar a alguien" a un pedido: pantalla completa.
@TypedGoRoute<AddDebtorRoute>(path: '/agregar-a-pedido/:orderId')
class AddDebtorRoute extends GoRouteData with $AddDebtorRoute {
  const new({required this.orderId});

  final String orderId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: AddDebtorPage(
          orderId: orderId,
          onBack: BackNavigation.to(
            context,
            fallback: OrderDetailRoute(orderId: orderId).location,
          ),
        ),
      );
}
