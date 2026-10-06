import 'package:flutter_riverpod/misc.dart';

import '../../features/inbox/presentation/navigation/inbox_navigator_provider.dart';
import '../../features/orders/data/orders_repository_provider.dart';
import '../../features/orders/presentation/navigation/orders_navigator_provider.dart';
import '../../features/teams/presentation/navigation/teams_navigator_provider.dart';
import '../router/app_router.dart';
import 'app_inbox_navigator.dart';
import 'app_orders_navigator.dart';
import 'app_teams_navigator.dart';
import 'router_opener.dart';

/// Cada feature declara a dónde quiere ir; aquí se responde con las rutas de
/// la app (los features no conocen URLs).
List<Override> navigationOverrides() => [
  ordersNavigatorProvider.overrideWith(
    (ref) => AppOrdersNavigator(RouterOpener(ref.watch(appRouterProvider))),
  ),
  teamsNavigatorProvider.overrideWith(
    (ref) => AppTeamsNavigator(RouterOpener(ref.watch(appRouterProvider))),
  ),
  inboxNavigatorProvider.overrideWith(
    (ref) => AppInboxNavigator(
      RouterOpener(ref.watch(appRouterProvider)),
      ref.watch(ordersRepositoryProvider),
    ),
  ),
];
