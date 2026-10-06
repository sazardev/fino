part of '../app_routes.dart';

class ChangelogRoute extends GoRouteData with $ChangelogRoute {
  const new();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: ChangelogPage(
          onBack: BackNavigation.to(
            context,
            fallback: const SettingsRoute().location,
          ),
        ),
      );
}
