import 'dart:math';

const _alphabet =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

/// Un id de 20 caracteres como los que reparte Firestore: sin coordinación
/// entre dispositivos y sin colisiones en la práctica (62^20 combinaciones).
String randomId([Random? random]) {
  final source = random ?? Random.secure();
  return String.fromCharCodes([
    for (var i = 0; i < 20; i++)
      _alphabet.codeUnitAt(source.nextInt(_alphabet.length)),
  ]);
}
