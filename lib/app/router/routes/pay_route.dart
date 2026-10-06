part of '../app_routes.dart';

/// *Pagar* a alguien: pantalla completa (es un flujo de captura).
@TypedGoRoute<PayRoute>(path: '/pagar/:teamId/:creditorId')
class PayRoute extends GoRouteData with $PayRoute {
  const new({required this.teamId, required this.creditorId});

  final String teamId;
  final String creditorId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: PayPage(
          teamId: teamId,
          creditorId: creditorId,
          onBack: BackNavigation.to(
            context,
            fallback: CounterpartRoute(
              teamId: teamId,
              userId: creditorId,
            ).location,
          ),
        ),
      );
}
