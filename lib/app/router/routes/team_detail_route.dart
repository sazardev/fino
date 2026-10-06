part of '../app_routes.dart';

/// Un equipo (dentro de Ajustes).
class TeamDetailRoute extends GoRouteData with $TeamDetailRoute {
  const new({required this.teamId});

  final String teamId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: TeamDetailPage(
          teamId: teamId,
          onBack: BackNavigation.to(
            context,
            fallback: const SettingsRoute().location,
          ),
        ),
      );
}
