import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../notification_channels.dart';
import '../notification_payload.dart';
import 'local_notifications_service.dart';

class FlutterLocalNotificationsService implements LocalNotificationsService {
  new(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;
  final _taps = StreamController<NotificationPayload>.broadcast();

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      NotificationChannels.defaultId,
      NotificationChannels.defaultName,
      channelDescription: NotificationChannels.defaultDescription,
      icon: 'ic_stat_fino',
    ),
  );

  @override
  Stream<NotificationPayload> get taps => _taps.stream;

  @override
  Future<void> initialize() async {
    // Schedules are absolute instants, so the default (UTC) location is fine.
    tz_data.initializeTimeZones();
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_fino'),
      ),
      onDidReceiveNotificationResponse: (response) => _emit(response.payload),
    );
    final launch = await _plugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      _emit(launch?.notificationResponse?.payload);
    }
  }

  void _emit(String? raw) {
    final payload = NotificationPayload.tryParse(raw);
    if (payload != null) _taps.add(payload);
  }

  @override
  Future<bool> requestPermission() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    return await android?.requestNotificationsPermission() ?? false;
  }

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
    NotificationPayload? payload,
  }) => _plugin.show(
    id: id,
    title: title,
    body: body,
    notificationDetails: _details,
    payload: payload?.location,
  );

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    NotificationPayload? payload,
  }) => _plugin.zonedSchedule(
    id: id,
    title: title,
    body: body,
    scheduledDate: tz.TZDateTime.from(at, tz.local),
    notificationDetails: _details,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    payload: payload?.location,
  );

  @override
  Future<void> cancel(int id) => _plugin.cancel(id: id);
}
