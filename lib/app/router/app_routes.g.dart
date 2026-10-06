// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $addDebtorRoute,
  $appShellRoute,
  $createTeamRoute,
  $editOrderRoute,
  $joinTeamRoute,
  $newOrderRoute,
  $noticeRoute,
  $payRoute,
  $payoutSetupRoute,
  $signInRoute,
];

RouteBase get $addDebtorRoute => GoRouteData.$route(
  path: '/agregar-a-pedido/:orderId',
  hasOverriddenOnExit: false,
  factory: $AddDebtorRoute._fromState,
);

mixin $AddDebtorRoute on GoRouteData {
  static AddDebtorRoute _fromState(GoRouterState state) =>
      AddDebtorRoute(orderId: state.pathParameters['orderId']!);

  AddDebtorRoute get _self => this as AddDebtorRoute;

  @override
  String get location => GoRouteData.$location(
    '/agregar-a-pedido/${Uri.encodeComponent(_self.orderId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $appShellRoute => StatefulShellRouteData.$route(
  navigatorContainerBuilder: AppShellRoute.$navigatorContainerBuilder,
  factory: $AppShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/',
          hasOverriddenOnExit: false,
          factory: $HomeRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'cuentas/:teamId/:userId',
              hasOverriddenOnExit: false,
              factory: $CounterpartRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/pedidos',
          hasOverriddenOnExit: false,
          factory: $OrdersRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: ':orderId',
              hasOverriddenOnExit: false,
              factory: $OrderDetailRoute._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/pagos/:paymentId',
          hasOverriddenOnExit: false,
          factory: $PaymentRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/buzon',
          hasOverriddenOnExit: false,
          factory: $InboxRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/ajustes',
          hasOverriddenOnExit: false,
          factory: $SettingsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'apariencia',
              hasOverriddenOnExit: false,
              factory: $AppearanceRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'novedades',
              hasOverriddenOnExit: false,
              factory: $ChangelogRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'componentes',
              hasOverriddenOnExit: false,
              factory: $GalleryRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'equipos/:teamId',
              hasOverriddenOnExit: false,
              factory: $TeamDetailRoute._fromState,
            ),
          ],
        ),
      ],
    ),
  ],
);

extension $AppShellRouteExtension on AppShellRoute {
  static AppShellRoute _fromState(GoRouterState state) => const AppShellRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CounterpartRoute on GoRouteData {
  static CounterpartRoute _fromState(GoRouterState state) => CounterpartRoute(
    teamId: state.pathParameters['teamId']!,
    userId: state.pathParameters['userId']!,
  );

  CounterpartRoute get _self => this as CounterpartRoute;

  @override
  String get location => GoRouteData.$location(
    '/cuentas/${Uri.encodeComponent(_self.teamId)}/${Uri.encodeComponent(_self.userId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OrdersRoute on GoRouteData {
  static OrdersRoute _fromState(GoRouterState state) => const OrdersRoute();

  @override
  String get location => GoRouteData.$location('/pedidos');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OrderDetailRoute on GoRouteData {
  static OrderDetailRoute _fromState(GoRouterState state) =>
      OrderDetailRoute(orderId: state.pathParameters['orderId']!);

  OrderDetailRoute get _self => this as OrderDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/pedidos/${Uri.encodeComponent(_self.orderId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PaymentRoute on GoRouteData {
  static PaymentRoute _fromState(GoRouterState state) =>
      PaymentRoute(paymentId: state.pathParameters['paymentId']!);

  PaymentRoute get _self => this as PaymentRoute;

  @override
  String get location =>
      GoRouteData.$location('/pagos/${Uri.encodeComponent(_self.paymentId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $InboxRoute on GoRouteData {
  static InboxRoute _fromState(GoRouterState state) => const InboxRoute();

  @override
  String get location => GoRouteData.$location('/buzon');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/ajustes');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AppearanceRoute on GoRouteData {
  static AppearanceRoute _fromState(GoRouterState state) =>
      const AppearanceRoute();

  @override
  String get location => GoRouteData.$location('/ajustes/apariencia');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChangelogRoute on GoRouteData {
  static ChangelogRoute _fromState(GoRouterState state) =>
      const ChangelogRoute();

  @override
  String get location => GoRouteData.$location('/ajustes/novedades');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GalleryRoute on GoRouteData {
  static GalleryRoute _fromState(GoRouterState state) => const GalleryRoute();

  @override
  String get location => GoRouteData.$location('/ajustes/componentes');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TeamDetailRoute on GoRouteData {
  static TeamDetailRoute _fromState(GoRouterState state) =>
      TeamDetailRoute(teamId: state.pathParameters['teamId']!);

  TeamDetailRoute get _self => this as TeamDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/ajustes/equipos/${Uri.encodeComponent(_self.teamId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createTeamRoute => GoRouteData.$route(
  path: '/nuevo-equipo',
  hasOverriddenOnExit: false,
  factory: $CreateTeamRoute._fromState,
);

mixin $CreateTeamRoute on GoRouteData {
  static CreateTeamRoute _fromState(GoRouterState state) =>
      const CreateTeamRoute();

  @override
  String get location => GoRouteData.$location('/nuevo-equipo');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $editOrderRoute => GoRouteData.$route(
  path: '/editar-pedido/:orderId',
  hasOverriddenOnExit: false,
  factory: $EditOrderRoute._fromState,
);

mixin $EditOrderRoute on GoRouteData {
  static EditOrderRoute _fromState(GoRouterState state) =>
      EditOrderRoute(orderId: state.pathParameters['orderId']!);

  EditOrderRoute get _self => this as EditOrderRoute;

  @override
  String get location => GoRouteData.$location(
    '/editar-pedido/${Uri.encodeComponent(_self.orderId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $joinTeamRoute => GoRouteData.$route(
  path: '/unirse',
  hasOverriddenOnExit: false,
  factory: $JoinTeamRoute._fromState,
);

mixin $JoinTeamRoute on GoRouteData {
  static JoinTeamRoute _fromState(GoRouterState state) =>
      JoinTeamRoute(codigo: state.uri.queryParameters['codigo']);

  JoinTeamRoute get _self => this as JoinTeamRoute;

  @override
  String get location => GoRouteData.$location(
    '/unirse',
    queryParams: {if (_self.codigo != null) 'codigo': _self.codigo},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $newOrderRoute => GoRouteData.$route(
  path: '/nuevo-pedido',
  hasOverriddenOnExit: false,
  factory: $NewOrderRoute._fromState,
);

mixin $NewOrderRoute on GoRouteData {
  static NewOrderRoute _fromState(GoRouterState state) => const NewOrderRoute();

  @override
  String get location => GoRouteData.$location('/nuevo-pedido');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $noticeRoute => GoRouteData.$route(
  path: '/nuevo-aviso/:teamId',
  hasOverriddenOnExit: false,
  factory: $NoticeRoute._fromState,
);

mixin $NoticeRoute on GoRouteData {
  static NoticeRoute _fromState(GoRouterState state) => NoticeRoute(
    teamId: state.pathParameters['teamId']!,
    para: state.uri.queryParameters['para'],
  );

  NoticeRoute get _self => this as NoticeRoute;

  @override
  String get location => GoRouteData.$location(
    '/nuevo-aviso/${Uri.encodeComponent(_self.teamId)}',
    queryParams: {if (_self.para != null) 'para': _self.para},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $payRoute => GoRouteData.$route(
  path: '/pagar/:teamId/:creditorId',
  hasOverriddenOnExit: false,
  factory: $PayRoute._fromState,
);

mixin $PayRoute on GoRouteData {
  static PayRoute _fromState(GoRouterState state) => PayRoute(
    teamId: state.pathParameters['teamId']!,
    creditorId: state.pathParameters['creditorId']!,
  );

  PayRoute get _self => this as PayRoute;

  @override
  String get location => GoRouteData.$location(
    '/pagar/${Uri.encodeComponent(_self.teamId)}/${Uri.encodeComponent(_self.creditorId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $payoutSetupRoute => GoRouteData.$route(
  path: '/cuenta-de-cobro/:teamId',
  hasOverriddenOnExit: false,
  factory: $PayoutSetupRoute._fromState,
);

mixin $PayoutSetupRoute on GoRouteData {
  static PayoutSetupRoute _fromState(GoRouterState state) =>
      PayoutSetupRoute(teamId: state.pathParameters['teamId']!);

  PayoutSetupRoute get _self => this as PayoutSetupRoute;

  @override
  String get location => GoRouteData.$location(
    '/cuenta-de-cobro/${Uri.encodeComponent(_self.teamId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInRoute => GoRouteData.$route(
  path: '/iniciar-sesion',
  hasOverriddenOnExit: false,
  factory: $SignInRoute._fromState,
);

mixin $SignInRoute on GoRouteData {
  static SignInRoute _fromState(GoRouterState state) =>
      SignInRoute(from: state.uri.queryParameters['from']);

  SignInRoute get _self => this as SignInRoute;

  @override
  String get location => GoRouteData.$location(
    '/iniciar-sesion',
    queryParams: {if (_self.from != null) 'from': _self.from},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
