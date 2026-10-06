import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Registra una prueba omitida y devuelve `true` cuando no hay emulador de
/// Firestore (se corre con `tool/test_rules.sh`): el `flutter test` normal no
/// debe fallar por eso.
bool skipWithoutRulesEmulator() {
  if (Platform.environment['FIRESTORE_EMULATOR_HOST'] != null) return false;
  test(
    'security rules (needs the emulator)',
    () {},
    skip: 'run tool/test_rules.sh',
  );
  return true;
}
