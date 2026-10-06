import 'dart:convert';

import '../database/outbox_operation.dart';
import 'remote_array_op.dart';
import 'remote_marker.dart';
import 'remote_write.dart';

/// Convierte campos remotos a JSON (columna `payload` del outbox) y de vuelta.
///
/// Lo que JSON no sabe expresar se codifica con una clave `\$`:
/// `{"\$t": millis}` fecha, `{"\$m": "serverTimestamp"}` marcador,
/// `{"\$a": "union"|"remove", "v": [...]}` operación de lista.
abstract final class RemoteWriteCodec {
  static String encode(Map<String, Object?> fields) =>
      jsonEncode(fields.map((key, value) => MapEntry(key, _encode(value))));

  static Map<String, Object?> decode(String payload) {
    if (payload.isEmpty) return const {};
    final json = jsonDecode(payload) as Map<String, dynamic>;
    return json.map((key, value) => MapEntry(key, _decode(value)));
  }

  /// Reconstruye la escritura de una entrada del outbox.
  static RemoteWrite toWrite({
    required String entity,
    required String entityId,
    required OutboxOperation operation,
    required String payload,
  }) => RemoteWrite(
    collection: entity,
    id: entityId,
    operation: operation,
    fields: decode(payload),
  );

  static Object? _encode(Object? value) => switch (value) {
    DateTime() => {r'$t': value.toUtc().millisecondsSinceEpoch},
    RemoteMarker() => {r'$m': value.name},
    RemoteArrayOp() => {
      r'$a': value.union ? 'union' : 'remove',
      'v': value.values.map(_encode).toList(),
    },
    List<Object?>() => value.map(_encode).toList(),
    Map<String, Object?>() => value.map((k, v) => MapEntry(k, _encode(v))),
    _ => value,
  };

  static Object? _decode(Object? value) {
    if (value is List<dynamic>) return value.map(_decode).toList();
    if (value is! Map<String, dynamic>) return value;
    if (value.containsKey(r'$t')) {
      return DateTime.fromMillisecondsSinceEpoch(
        value[r'$t'] as int,
        isUtc: true,
      );
    }
    if (value.containsKey(r'$m')) {
      return RemoteMarker.values.byName(value[r'$m'] as String);
    }
    if (value.containsKey(r'$a')) {
      final values = (value['v'] as List<dynamic>).map(_decode).toList();
      return value[r'$a'] == 'union'
          ? RemoteArrayOp.union(values)
          : RemoteArrayOp.remove(values);
    }
    return value.map((k, v) => MapEntry(k, _decode(v)));
  }
}
