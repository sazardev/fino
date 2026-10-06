part of '../app_routes.dart';

/// The frame: primary navigation around one stack per destination.
@TypedStatefulShellRoute<AppShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeBranch>(
      routes: [TypedGoRoute<HomeRoute>(path: '/')],
    ),
    TypedStatefulShellBranch<GalleryBranch>(
      routes: [TypedGoRoute<GalleryRoute>(path: '/componentes')],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: [
        TypedGoRoute<SettingsRoute>(
          path: '/ajustes',
          routes: [
            TypedGoRoute<AppearanceRoute>(path: 'apariencia'),
            TypedGoRoute<ChangelogRoute>(path: 'novedades'),
          ],
        ),
      ],
    ),
  ],
)
class AppShellRoute extends StatefulShellRouteData {
  const new();

  // The branches' navigators are handed to the frame, which keeps them alive
  // across destination switches and bar ↔ rail changes.
  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) => AppShell(navigationShell: navigationShell, branches: children);

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => navigationShell;
}
