import 'dart:io';

/// Whether the Firebase emulators are listening, so emulator tests can skip
/// themselves when `tool/emulators.sh` is not running.
Future<bool> emulatorsRunning({int authPort = 9099}) async {
  try {
    final socket = await Socket.connect(
      'localhost',
      authPort,
      timeout: const Duration(seconds: 1),
    );
    await socket.close();
    return true;
  } on Object {
    return false;
  }
}
