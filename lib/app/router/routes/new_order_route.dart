part of '../app_routes.dart';

/// "Nuevo pedido": pantalla completa, sobre la navegación.
@TypedGoRoute<NewOrderRoute>(path: '/nuevo-pedido')
class NewOrderRoute extends GoRouteData with $NewOrderRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: OrderFormPage(
          onBack: BackNavigation.to(
            context,
            fallback: const HomeRoute().location,
          ),
        ),
      );
}
