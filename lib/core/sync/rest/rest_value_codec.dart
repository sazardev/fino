/// Valores de la API REST de Firestore (`{"stringValue": "…"}`) ↔ Dart.
abstract final class RestValueCodec {
  static Map<String, Object?> encode(Object? value) => switch (value) {
    null => {'nullValue': null},
    bool() => {'booleanValue': value},
    int() => {'integerValue': '$value'},
    double() => {'doubleValue': value},
    String() => {'stringValue': value},
    DateTime() => {'timestampValue': value.toUtc().toIso8601String()},
    List<Object?>() => {
      'arrayValue': {'values': value.map(encode).toList()},
    },
    Map<String, Object?>() => {
      'mapValue': {'fields': encodeFields(value)},
    },
    _ => throw ArgumentError('Unsupported value: $value'),
  };

  static Map<String, Object?> encodeFields(Map<String, Object?> fields) => {
    for (final MapEntry(:key, :value) in fields.entries) key: encode(value),
  };

  static Object? decode(Map<String, Object?> value) {
    if (value.containsKey('nullValue')) return null;
    if (value['booleanValue'] case final bool b) return b;
    if (value['integerValue'] case final Object i) return int.parse('$i');
    if (value['doubleValue'] case final num d) return d.toDouble();
    if (value['stringValue'] case final String s) return s;
    if (value['timestampValue'] case final String t) {
      return DateTime.parse(t).toUtc();
    }
    if (value['arrayValue'] case final Map<String, Object?> array) {
      final values = (array['values'] as List<Object?>?) ?? const [];
      return [for (final v in values) decode(v! as Map<String, Object?>)];
    }
    if (value['mapValue'] case final Map<String, Object?> map) {
      return decodeFields((map['fields'] as Map<String, Object?>?) ?? const {});
    }
    return null;
  }

  static Map<String, Object?> decodeFields(Map<String, Object?> fields) => {
    for (final MapEntry(:key, :value) in fields.entries)
      key: decode(value! as Map<String, Object?>),
  };
}
