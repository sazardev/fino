import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../core/analytics/analytics_service.dart';
import '../../core/analytics/events/screen_viewed.dart';

/// Logs a screen view each time the router lands on a new path. Returns the
/// function that stops tracking.
VoidCallback trackScreenViews({
  required GoRouter router,
  required AnalyticsService analytics,
}) {
  String? last;
  void onChange() {
    final path = router.routerDelegate.currentConfiguration.uri.path;
    if (path == last) return;
    last = path;
    unawaited(analytics.log(ScreenViewed(path)));
  }

  router.routerDelegate.addListener(onChange);
  return () => router.routerDelegate.removeListener(onChange);
}
