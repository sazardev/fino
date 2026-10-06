import 'dart:convert';
import 'dart:io';

import '../remote_failure.dart';
import '../remote_failure_kind.dart';

/// Respuestas HTTP y errores de red → [RemoteFailure].
abstract final class RestFailureMapper {
  static RemoteFailure fromResponse(int status, String body) {
    final kind = switch (status) {
      401 => RemoteFailureKind.unauthenticated,
      403 => RemoteFailureKind.permissionDenied,
      404 => RemoteFailureKind.notFound,
      409 => RemoteFailureKind.alreadyExists,
      429 || 503 || 504 => RemoteFailureKind.unavailable,
      _ => RemoteFailureKind.other,
    };
    return RemoteFailure(kind, _message(body));
  }

  static RemoteFailure fromError(Object error) => switch (error) {
    RemoteFailure() => error,
    SocketException() || HttpException() || HandshakeException() =>
      RemoteFailure(RemoteFailureKind.unavailable, '$error'),
    _ => RemoteFailure(RemoteFailureKind.other, '$error'),
  };

  static String _message(String body) {
    try {
      final json = jsonDecode(body);
      if (json is Map<String, Object?> &&
          json['error'] is Map<String, Object?>) {
        return (json['error']! as Map<String, Object?>)['message']
                ?.toString() ??
            body;
      }
      if (json is List<Object?> && json.isNotEmpty) {
        return _message(jsonEncode(json.first));
      }
    } on FormatException {
      return body;
    }
    return body;
  }
}
