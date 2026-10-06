part of '../app_routes.dart';

/// A full-screen form above the navigation (root navigator, no shell).
@TypedGoRoute<ComposeRoute>(path: '/nuevo')
class ComposeRoute extends GoRouteData with $ComposeRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: ComposePage(
          onBack: BackNavigation.to(
            context,
            fallback: const HomeRoute().location,
          ),
        ),
      );
}
