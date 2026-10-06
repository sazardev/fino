part of '../app_routes.dart';

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: SettingsPage());
}
