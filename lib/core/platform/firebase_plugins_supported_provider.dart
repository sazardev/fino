import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'firebase_plugins_supported.dart';

part 'firebase_plugins_supported_provider.g.dart';

/// Overridable so tests can exercise the Linux paths from any host.
@Riverpod(keepAlive: true)
bool firebasePluginsSupportedFlag(Ref ref) => firebasePluginsSupported;
