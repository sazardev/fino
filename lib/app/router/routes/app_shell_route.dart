part of '../app_routes.dart';

/// The frame: primary navigation around one stack per destination.
@TypedStatefulShellRoute<AppShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeBranch>(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: '/',
          routes: [
            TypedGoRoute<CounterpartRoute>(path: 'cuentas/:teamId/:userId'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<OrdersBranch>(
      routes: [
        TypedGoRoute<OrdersRoute>(
          path: '/pedidos',
          routes: [TypedGoRoute<OrderDetailRoute>(path: ':orderId')],
        ),
        TypedGoRoute<PaymentRoute>(path: '/pagos/:paymentId'),
      ],
    ),
    TypedStatefulShellBranch<InboxBranch>(
      routes: [TypedGoRoute<InboxRoute>(path: '/buzon')],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: [
        TypedGoRoute<SettingsRoute>(
          path: '/ajustes',
          routes: [
            TypedGoRoute<AppearanceRoute>(path: 'apariencia'),
            TypedGoRoute<ChangelogRoute>(path: 'novedades'),
            TypedGoRoute<GalleryRoute>(path: 'componentes'),
            TypedGoRoute<TeamDetailRoute>(path: 'equipos/:teamId'),
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
