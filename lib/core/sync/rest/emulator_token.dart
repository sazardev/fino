import 'dart:convert';

/// Un token sin firma que el emulador de Firestore acepta como sesión de
/// [uid]. **Solo sirve contra el emulador**: un backend real lo rechaza.
String emulatorTokenFor(String uid) {
  String part(Map<String, Object?> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  final header = part({'alg': 'none', 'kid': 'fake'});
  final payload = part({
    'user_id': uid,
    'sub': uid,
    'firebase': {'sign_in_provider': 'google.com'},
  });
  return '$header.$payload.';
}
