import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/analytics/analytics_service_provider.dart';
import '../../core/flavor/flavor_config_provider.dart';
import '../../core/notifications/notifications_coordinator_provider.dart';
import '../../features/auth/presentation/providers/auth_state_provider.dart';
import 'app_routes.dart';
import 'auth_redirect.dart';
import 'auth_refresh_listenable.dart';
import 'open_notification_routes.dart';
import 'track_screen_views.dart';

part 'app_router.g.dart';

/// The app's single router: typed routes, auth guard, deep links, and the
/// notification and analytics hooks that depend on navigation.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = AuthRefreshListenable(ref);
  final router = GoRouter(
    routes: $appRoutes,
    refreshListenable: refresh,
    debugLogDiagnostics: ref.watch(flavorConfigProvider).verboseLogging,
    redirect: (context, state) =>
        authRedirect(auth: ref.read(authStateProvider), location: state.uri),
  );

  final opens = openNotificationRoutes(
    router: router,
    opens: ref.watch(notificationsCoordinatorProvider).opens,
  );
  final stopTracking = trackScreenViews(
    router: router,
    analytics: ref.watch(analyticsServiceProvider),
  );

  ref.onDispose(() {
    unawaited(opens.cancel());
    stopTracking();
    refresh.dispose();
    router.dispose();
  });
  return router;
}
