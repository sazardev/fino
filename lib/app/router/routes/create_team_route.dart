part of '../app_routes.dart';

/// "Nuevo equipo": pantalla completa.
@TypedGoRoute<CreateTeamRoute>(path: '/nuevo-equipo')
class CreateTeamRoute extends GoRouteData with $CreateTeamRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: CreateTeamPage(
          onBack: BackNavigation.to(
            context,
            fallback: const SettingsRoute().location,
          ),
        ),
      );
}
