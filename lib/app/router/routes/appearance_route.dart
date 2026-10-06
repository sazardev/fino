part of '../app_routes.dart';

class AppearanceRoute extends GoRouteData with $AppearanceRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(key: state.pageKey, child: const AppearancePage());
}
