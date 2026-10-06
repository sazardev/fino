import 'package:cloud_firestore/cloud_firestore.dart';

import '../remote_array_op.dart';
import '../remote_marker.dart';

/// Valores de la app ↔ valores del SDK de Firestore.
abstract final class FirestoreValueCodec {
  /// Lo que se manda: fechas como `Timestamp`, marcadores y operaciones de
  /// lista como `FieldValue`.
  static Object? encode(Object? value) => switch (value) {
    DateTime() => Timestamp.fromDate(value),
    RemoteMarker.serverTimestamp => FieldValue.serverTimestamp(),
    RemoteMarker.fieldDelete => FieldValue.delete(),
    RemoteArrayOp(:final union, :final values) =>
      union
          ? FieldValue.arrayUnion(values.map(encode).toList())
          : FieldValue.arrayRemove(values.map(encode).toList()),
    List<Object?>() => value.map(encode).toList(),
    Map<String, Object?>() => encodeFields(value),
    _ => value,
  };

  static Map<String, Object?> encodeFields(Map<String, Object?> fields) => {
    for (final MapEntry(:key, :value) in fields.entries) key: encode(value),
  };

  /// Lo que llega: `Timestamp` → `DateTime` en UTC; el resto tal cual.
  static Object? decode(Object? value) => switch (value) {
    Timestamp() => value.toDate().toUtc(),
    List<Object?>() => value.map(decode).toList(),
    Map<Object?, Object?>() => {
      for (final entry in value.entries) '${entry.key}': decode(entry.value),
    },
    _ => value,
  };

  static Map<String, Object?> decodeFields(Map<String, Object?>? fields) => {
    for (final MapEntry(:key, :value) in (fields ?? const {}).entries)
      key: decode(value),
  };
}
