import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase/firestore_provider.dart';
import '../flavor/flavor_config_provider.dart';
import '../platform/firebase_plugins_supported_provider.dart';
import '../session/session_user_id_provider.dart';
import 'remote_gateway.dart';
import 'rest/emulator_token.dart';
import 'rest/firestore_rest_gateway.dart';
import 'sdk/cloud_firestore_gateway.dart';

part 'remote_gateway_provider.g.dart';

/// La puerta a Firestore: el SDK donde existe (Android, web) y REST contra el
/// emulador donde no (Linux).
@Riverpod(keepAlive: true)
RemoteGateway remoteGateway(Ref ref) {
  if (ref.watch(firebasePluginsSupportedFlagProvider)) {
    return CloudFirestoreGateway(ref.watch(firebaseFirestoreProvider));
  }
  final config = ref.watch(flavorConfigProvider);
  final emulators = config.emulators!;
  return FirestoreRestGateway(
    host: '${emulators.host}:${emulators.firestorePort}',
    project: config.firebaseOptions.projectId,
    tokenProvider: () {
      final uid = ref.read(sessionUserIdProvider);
      return uid == null ? null : emulatorTokenFor(uid);
    },
  );
}
