part of '../app_routes.dart';

class GalleryRoute extends GoRouteData with $GalleryRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: GalleryPage());
}
