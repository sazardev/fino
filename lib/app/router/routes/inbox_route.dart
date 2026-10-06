part of '../app_routes.dart';

class InboxRoute extends GoRouteData with $InboxRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: InboxPage());
}
