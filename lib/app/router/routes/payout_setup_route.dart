part of '../app_routes.dart';

/// "Cuenta de cobro" en un equipo: pantalla completa.
@TypedGoRoute<PayoutSetupRoute>(path: '/cuenta-de-cobro/:teamId')
class PayoutSetupRoute extends GoRouteData with $PayoutSetupRoute {
  const new({required this.teamId});

  final String teamId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: PayoutMethodPage(
          teamId: teamId,
          onBack: BackNavigation.to(
            context,
            fallback: TeamDetailRoute(teamId: teamId).location,
          ),
        ),
      );
}
