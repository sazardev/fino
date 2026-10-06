part of '../app_routes.dart';

class HomeRoute extends GoRouteData with $HomeRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: HomePage());
}
