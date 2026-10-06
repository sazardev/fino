import 'dart:convert';
import 'dart:io';

import '../remote_failure.dart';
import 'rest_failure_mapper.dart';

/// Hace una petición JSON y devuelve el cuerpo ya decodificado.
///
/// Se inyecta en el gateway para poder probarlo sin red. Lanza
/// `RemoteFailure` ante cualquier error.
typedef RestRequest = Future<Object?> Function(
  String method,
  Uri url, {
  Map<String, Object?>? body,
  String? bearerToken,
});

/// [RestRequest] sobre `dart:io`. Solo corre donde no hay plugins de
/// Firebase (Linux) y en pruebas; nunca en web.
Future<Object?> ioRestRequest(
  String method,
  Uri url, {
  Map<String, Object?>? body,
  String? bearerToken,
}) async {
  final client = HttpClient();
  try {
    final request = await client.openUrl(method, url);
    request.headers.contentType = ContentType.json;
    if (bearerToken != null) {
      request.headers.set('Authorization', 'Bearer $bearerToken');
    }
    if (body != null) request.write(jsonEncode(body));
    final response = await request.close();
    final text = await utf8.decodeStream(response);
    if (response.statusCode >= 400) {
      throw RestFailureMapper.fromResponse(response.statusCode, text);
    }
    return text.isEmpty ? null : jsonDecode(text);
  } on RemoteFailure {
    rethrow;
  } on Object catch (error) {
    throw RestFailureMapper.fromError(error);
  } finally {
    client.close();
  }
}
