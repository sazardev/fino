import '../../database/outbox_operation.dart';
import '../remote_array_op.dart';
import '../remote_marker.dart';
import '../remote_write.dart';
import 'rest_value_codec.dart';

/// [RemoteWrite] → escritura de `:commit` de la API REST.
abstract final class RestWriteEncoder {
  /// [documents] es `projects/{p}/databases/(default)/documents`.
  static Map<String, Object?> encode(RemoteWrite write, String documents) {
    final name = '$documents/${write.path}';
    if (write.operation == OutboxOperation.delete) return {'delete': name};

    final fields = <String, Object?>{};
    final deleted = <String>[];
    final transforms = <Map<String, Object?>>[];
    for (final MapEntry(:key, :value) in write.fields.entries) {
      switch (value) {
        case RemoteMarker.serverTimestamp:
          transforms.add({
            'fieldPath': key,
            'setToServerValue': 'REQUEST_TIME',
          });
        case RemoteMarker.fieldDelete:
          deleted.add(key);
        case RemoteArrayOp(:final union, :final values):
          transforms.add({
            'fieldPath': key,
            union ? 'appendMissingElements' : 'removeAllFromArray': {
              'values': values.map(RestValueCodec.encode).toList(),
            },
          });
        default:
          fields[key] = RestValueCodec.encode(value);
      }
    }
    final isUpdate = write.operation == OutboxOperation.update;
    return {
      'update': {'name': name, 'fields': fields},
      if (isUpdate) ...{
        'updateMask': {
          'fieldPaths': [...fields.keys, ...deleted],
        },
        'currentDocument': {'exists': true},
      },
      if (transforms.isNotEmpty) 'updateTransforms': transforms,
    };
  }
}
