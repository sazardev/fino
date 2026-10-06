import 'dart:convert';
import 'dart:io';

/// Valor que el servidor reemplaza por la hora de la petición (`request.time`).
class ServerTime {
  const new();
}

/// `FieldValue.arrayUnion` / `arrayRemove` de un solo nivel.
class ArrayUnion {
  const new(this.values);
  final List<Object?> values;
}

class ArrayRemove {
  const new(this.values);
  final List<Object?> values;
}

/// Una escritura de un batch (`:commit`).
sealed class Write {
  const new(this.path);

  /// `create`: falla si el documento ya existe.
  const factory create(String path, Map<String, Object?> data) = _Create;

  /// `update`: solo toca [data] (y borra [deleteFields]); falla si no existe.
  const factory update(
    String path,
    Map<String, Object?> data, {
    List<String> deleteFields,
  }) = _Update;

  /// `set`: crea o reemplaza (idempotente).
  const factory set(String path, Map<String, Object?> data) = _Set;

  const factory remove(String path) = _Remove;
  final String path;

  Map<String, Object?> toJson(String documents);
}

class _Create extends Write {
  const new(super.path, this.data);
  final Map<String, Object?> data;

  @override
  Map<String, Object?> toJson(String documents) =>
      _upsert(documents, path, data, precondition: {'exists': false});
}

class _Update extends Write {
  const new(super.path, this.data, {this.deleteFields = const []});
  final Map<String, Object?> data;
  final List<String> deleteFields;

  @override
  Map<String, Object?> toJson(String documents) => _upsert(
    documents,
    path,
    data,
    precondition: {'exists': true},
    masked: true,
    deleteFields: deleteFields,
  );
}

class _Set extends Write {
  const new(super.path, this.data);
  final Map<String, Object?> data;

  @override
  Map<String, Object?> toJson(String documents) =>
      _upsert(documents, path, data, precondition: null);
}

class _Remove extends Write {
  const new(super.path);

  @override
  Map<String, Object?> toJson(String documents) => {
    'delete': '$documents/$path',
  };
}

Map<String, Object?> _upsert(
  String documents,
  String path,
  Map<String, Object?> data, {
  required Map<String, Object?>? precondition,
  bool masked = false,
  List<String> deleteFields = const [],
}) {
  final fields = <String, Object?>{};
  final transforms = <Map<String, Object?>>[];
  for (final MapEntry(:key, :value) in data.entries) {
    switch (value) {
      case ServerTime():
        transforms.add({'fieldPath': key, 'setToServerValue': 'REQUEST_TIME'});
      case ArrayUnion(:final values):
        transforms.add({
          'fieldPath': key,
          'appendMissingElements': {'values': values.map(encode).toList()},
        });
      case ArrayRemove(:final values):
        transforms.add({
          'fieldPath': key,
          'removeAllFromArray': {'values': values.map(encode).toList()},
        });
      default:
        fields[key] = encode(value);
    }
  }
  return {
    'update': {'name': '$documents/$path', 'fields': fields},
    if (masked)
      'updateMask': {
        'fieldPaths': [...fields.keys, ...deleteFields],
      },
    'currentDocument': ?precondition,
    if (transforms.isNotEmpty) 'updateTransforms': transforms,
  };
}

Map<String, Object?> encode(Object? value) => switch (value) {
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
    'mapValue': {
      'fields': {for (final e in value.entries) e.key: encode(e.value)},
    },
  },
  _ => throw ArgumentError('Unsupported value: $value'),
};

/// Resultado de una petición: permitida o rechazada por las reglas.
class RestResult {
  const new(this.status, this.body);

  final int status;
  final String body;

  bool get allowed => status == 200;
  bool get denied => status == 403;

  @override
  String toString() => 'RestResult($status, $body)';
}

/// Cliente mínimo de la API REST de Firestore contra el emulador.
class FirestoreRest {
  const new({required this.host, required this.port, required this.project});

  /// Lee `FIRESTORE_EMULATOR_HOST` (lo define `firebase emulators:exec`).
  factory fromEnvironment() {
    final hostPort = Platform.environment['FIRESTORE_EMULATOR_HOST'];
    if (hostPort == null) throw StateError('Run through tool/test_rules.sh');
    final parts = hostPort.split(':');
    return FirestoreRest(
      host: parts.first,
      port: int.parse(parts.last),
      project: 'demo-fino-rules',
    );
  }

  final String host;
  final int port;
  final String project;

  String get _documents => 'projects/$project/databases/(default)/documents';

  /// Un token sin firma: el emulador lo acepta y evalúa las reglas con él.
  /// `null` = petición sin sesión; `'owner'` = administrador (ignora reglas).
  static String tokenFor(String uid) {
    String part(Map<String, Object?> json) =>
        base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
    return '${part({'alg': 'none', 'kid': 'fake'})}.'
        '${part({
          'user_id': uid,
          'sub': uid,
          'aud': 'demo-fino-rules',
          'firebase': {'sign_in_provider': 'google.com'},
        })}.';
  }

  Future<RestResult> commit(String? token, List<Write> writes) =>
      _send('POST', '/v1/$_documents:commit', token, {
        'writes': [for (final w in writes) w.toJson(_documents)],
      });

  Future<RestResult> get(String? token, String path) =>
      _send('GET', '/v1/$_documents/$path', token);

  /// Todos los documentos llamados [collectionId] (cualquier profundidad)
  /// cuyo campo [field] vale [value].
  Future<RestResult> collectionGroup(
    String? token,
    String collectionId,
    String field,
    String value,
  ) => _send('POST', '/v1/$_documents:runQuery', token, {
    'structuredQuery': {
      'from': [
        {'collectionId': collectionId, 'allDescendants': true},
      ],
      'where': {
        'fieldFilter': {
          'field': {'fieldPath': field},
          'op': 'EQUAL',
          'value': {'stringValue': value},
        },
      },
    },
  });

  /// Lista los documentos de una colección (una petición `list`).
  Future<RestResult> list(String? token, String path) =>
      _send('GET', '/v1/$_documents/$path', token);

  Future<RestResult> _send(
    String method,
    String path,
    String? token, [
    Map<String, Object?>? body,
  ]) async {
    final client = HttpClient();
    try {
      final request = await client.openUrl(
        method,
        Uri.http('$host:$port', path),
      );
      request.headers.contentType = ContentType.json;
      if (token != null) {
        request.headers.set('Authorization', 'Bearer $token');
      }
      if (body != null) request.write(jsonEncode(body));
      final response = await request.close();
      return RestResult(
        response.statusCode,
        await response.transform(utf8.decoder).join(),
      );
    } finally {
      client.close();
    }
  }
}
