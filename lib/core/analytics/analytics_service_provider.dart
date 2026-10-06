import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase/firebase_analytics_provider.dart';
import 'analytics_service.dart';
import 'firebase_analytics_service.dart';

part 'analytics_service_provider.g.dart';

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) =>
    FirebaseAnalyticsService(ref.watch(firebaseAnalyticsProvider));
