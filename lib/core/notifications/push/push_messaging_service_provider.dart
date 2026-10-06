import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../firebase/firebase_messaging_provider.dart';
import '../../platform/firebase_plugins_supported_provider.dart';
import 'firebase_push_messaging_service.dart';
import 'noop_push_messaging_service.dart';
import 'push_messaging_service.dart';

part 'push_messaging_service_provider.g.dart';

@Riverpod(keepAlive: true)
PushMessagingService pushMessagingService(Ref ref) =>
    kIsWeb || !ref.watch(firebasePluginsSupportedFlagProvider)
    ? NoopPushMessagingService()
    : FirebasePushMessagingService(ref.watch(firebaseMessagingProvider));
