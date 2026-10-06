import 'dart:io';

import 'package:fino/core/sync/rest/emulator_token.dart';
import 'package:fino/core/sync/rest/firestore_rest_gateway.dart';

/// Un gateway REST que actúa como [uid] contra el emulador de pruebas.
FirestoreRestGateway gatewayFor(
  String uid, {
  Duration poll = const Duration(milliseconds: 60),
}) => FirestoreRestGateway(
  host: Platform.environment['FIRESTORE_EMULATOR_HOST']!,
  project: 'demo-fino-rules',
  tokenProvider: () => emulatorTokenFor(uid),
  pollInterval: poll,
);
