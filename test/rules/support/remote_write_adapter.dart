import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/sync/remote_array_op.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/core/sync/remote_write.dart';

import 'firestore_rest.dart';

/// Traduce las escrituras de la app a la API REST del emulador, igual que lo
/// hará el SDK de Firestore en producción.
abstract final class RemoteWriteAdapter {
  static List<Write> toRest(Iterable<RemoteWrite> writes) => [
    for (final write in writes) _convert(write),
  ];

  static Write _convert(RemoteWrite write) {
    final data = <String, Object?>{};
    final deleted = <String>[];
    for (final MapEntry(:key, :value) in write.fields.entries) {
      switch (value) {
        case RemoteMarker.serverTimestamp:
          data[key] = const ServerTime();
        case RemoteMarker.fieldDelete:
          deleted.add(key);
        case RemoteArrayOp(:final union, :final values):
          data[key] = union ? ArrayUnion(values) : ArrayRemove(values);
        default:
          data[key] = value;
      }
    }
    return switch (write.operation) {
      OutboxOperation.create => Write.create(write.path, data),
      OutboxOperation.update => Write.update(
        write.path,
        data,
        deleteFields: deleted,
      ),
      OutboxOperation.set => Write.set(write.path, data),
      OutboxOperation.delete => Write.remove(write.path),
    };
  }
}
