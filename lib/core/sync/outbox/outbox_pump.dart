import 'dart:async';

import '../../database/daos/outbox_dao.dart';
import '../../logging/app_logger.dart';
import '../../time/clock.dart';
import 'outbox_processor.dart';
import 'outbox_rejection.dart';

/// Mantiene el outbox fluyendo hacia el servidor: vacía la cola cuando algo
/// se encola y reintenta cuando toca tras una falla de red.
class OutboxPump {
  new({
    required this._dao,
    required this._processor,
    required this._clock,
    this._onRejected,
    this._logger,
  });

  final OutboxDao _dao;
  final OutboxProcessor _processor;
  final Clock _clock;
  final Future<void> Function(OutboxRejection)? _onRejected;
  final AppLogger? _logger;

  StreamSubscription<int>? _pending;
  Timer? _retry;
  var _running = false;

  void start() {
    if (_running) return;
    _running = true;
    _pending = _dao.watchPendingCount().listen((count) {
      if (count > 0) unawaited(flushNow());
    });
  }

  void stop() {
    _running = false;
    _retry?.cancel();
    _retry = null;
    unawaited(_pending?.cancel());
    _pending = null;
  }

  /// Una pasada ahora (p. ej. al recuperar la conexión).
  Future<void> flushNow() async {
    if (!_running) return;
    _retry?.cancel();
    _retry = null;
    try {
      final result = await _processor.flush();
      for (final rejection in result.rejections) {
        _logger?.warning(
          'Batch ${rejection.batchId} rejected: ${rejection.failure}',
        );
        await _onRejected?.call(rejection);
      }
      final retryAt = result.retryAt;
      if (retryAt != null && _running) {
        final wait = retryAt.difference(_clock());
        _retry = Timer(wait.isNegative ? Duration.zero : wait, flushNow);
      }
    } on Object catch (error) {
      _logger?.error('Outbox flush failed', error, StackTrace.current);
    }
  }
}
