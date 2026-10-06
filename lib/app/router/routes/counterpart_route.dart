part of '../app_routes.dart';

/// Mis cuentas con una persona en un equipo (dentro de Inicio).
class CounterpartRoute extends GoRouteData with $CounterpartRoute {
  const new({required this.teamId, required this.userId});

  final String teamId;
  final String userId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: CounterpartPage(
          teamId: teamId,
          userId: userId,
          onBack: BackNavigation.to(
            context,
            fallback: const HomeRoute().location,
          ),
        ),
      );
}
