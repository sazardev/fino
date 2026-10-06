import '../../database/app_database.dart';
import '../../database/daos/outbox_dao.dart';
import '../../time/clock.dart';
import '../remote_failure.dart';
import '../remote_gateway.dart';
import '../remote_write.dart';
import '../remote_write_codec.dart';
import 'flush_result.dart';
import 'outbox_rejection.dart';

/// Vacía el outbox hacia Firestore: un lote atómico a la vez, en orden.
///
/// - Éxito: el lote sale de la cola.
/// - Falla transitoria (red): el lote espera su reintento y la cola se
///   detiene (lo que sigue depende de lo que no llegó).
/// - Rechazo permanente (reglas): el lote se descarta y se avisa en
///   [FlushResult.rejections] para que lo local vuelva al estado del servidor.
class OutboxProcessor {
  new({required this._dao, required this._gateway, required this._clock});

  final OutboxDao _dao;
  final RemoteGateway _gateway;
  final Clock _clock;

  Future<FlushResult>? _running;

  /// Una sola pasada a la vez: si ya hay una en curso, se une a ella.
  Future<FlushResult> flush() =>
      _running ??= _flush().whenComplete(() => _running = null);

  Future<FlushResult> _flush() async {
    var committed = 0;
    final rejections = <OutboxRejection>[];
    while (true) {
      final head = await _dao.head();
      if (head == null) {
        return FlushResult(committed: committed, rejections: rejections);
      }
      final now = _clock();
      if (head.nextAttemptAt.isAfter(now)) {
        return FlushResult(
          committed: committed,
          rejections: rejections,
          retryAt: head.nextAttemptAt.toUtc(),
        );
      }

      final entries = head.batchId.isEmpty
          ? [head]
          : await _dao.batchOf(head.batchId);
      final writes = _writes(entries);
      try {
        await _gateway.commit(writes);
        await _dao.removeAll(entries.map((e) => e.id));
        committed++;
      } on RemoteFailure catch (failure) {
        if (failure.isTransient) {
          await _dao.markBatchFailed(entries, now: now);
          final next = (await _dao.head())!;
          return FlushResult(
            committed: committed,
            rejections: rejections,
            retryAt: next.nextAttemptAt.toUtc(),
          );
        }
        await _dao.removeAll(entries.map((e) => e.id));
        rejections.add(
          OutboxRejection(
            batchId: head.batchId,
            paths: [for (final write in writes) write.path],
            failure: failure,
          ),
        );
      }
    }
  }

  List<RemoteWrite> _writes(List<OutboxEntry> entries) => [
    for (final entry in entries)
      RemoteWriteCodec.toWrite(
        entity: entry.entity,
        entityId: entry.entityId,
        operation: entry.operation,
        payload: entry.payload,
      ),
  ];
}
