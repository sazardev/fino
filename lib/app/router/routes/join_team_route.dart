part of '../app_routes.dart';

/// Entrar a un equipo con su código (`/unirse?codigo=…` llega prellenado).
@TypedGoRoute<JoinTeamRoute>(path: '/unirse')
class JoinTeamRoute extends GoRouteData with $JoinTeamRoute {
  const new({this.codigo});

  final String? codigo;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: JoinTeamPage(
          code: codigo,
          onBack: BackNavigation.to(
            context,
            fallback: const SettingsRoute().location,
          ),
        ),
      );
}
