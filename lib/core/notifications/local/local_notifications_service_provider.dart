import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flutter_local_notifications_service.dart';
import 'local_notifications_service.dart';
import 'noop_local_notifications_service.dart';

part 'local_notifications_service_provider.g.dart';

@Riverpod(keepAlive: true)
LocalNotificationsService localNotificationsService(Ref ref) => kIsWeb
    ? NoopLocalNotificationsService()
    : FlutterLocalNotificationsService(FlutterLocalNotificationsPlugin());
