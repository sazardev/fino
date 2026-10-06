import 'dart:async';

import '../../logging/app_logger.dart';
import '../remote_failure.dart';
import '../remote_failure_kind.dart';

/// Una escucha que se levanta sola: si el flujo falla, vuelve a empezar tras
/// una espera (más larga si las reglas rechazaron la consulta).
class ResilientSubscription {
  new({
    required this.name,
    required this._open,
    this._logger,
    this.retryDelay = const Duration(seconds: 3),
    this.deniedRetryDelay = const Duration(seconds: 30),
  });

  final String name;
  final Duration retryDelay;
  final Duration deniedRetryDelay;

  /// Abre el flujo ya aplicando lo que llega (p. ej. `.asyncMap(apply)`).
  final Stream<void> Function() _open;
  final AppLogger? _logger;

  // ignore: cancel_subscriptions, cancelled in stop() through _discard
  StreamSubscription<void>? _subscription;
  Timer? _retry;
  var _running = false;

  /// Empieza a escuchar (no hace nada si ya escucha).
  void start() {
    if (_running) return;
    _running = true;
    _listen();
  }

  /// Vuelve a empezar desde cero: la instantánea inicial vuelve a traer todo
  /// (sirve para reconciliar tras un lote rechazado).
  void restart() {
    stop();
    start();
  }

  void stop() {
    _running = false;
    _retry?.cancel();
    _retry = null;
    _discard(_subscription);
    _subscription = null;
  }

  /// Cancela sin que un error tardío de la consulta en vuelo (p. ej. permiso
  /// denegado justo al salir del equipo) escape como excepción sin manejar.
  static void _discard(StreamSubscription<void>? subscription) {
    if (subscription == null) return;
    unawaited(subscription.cancel().then<void>((_) {}, onError: (Object _) {}));
  }

  void _listen() {
    _subscription = _open().listen(
      (_) {},
      onError: _failed,
      cancelOnError: true,
    );
  }

  void _failed(Object error, StackTrace stackTrace) {
    _logger?.warning('Sync "$name" failed: $error');
    if (!_running) return;
    final denied =
        error is RemoteFailure &&
        error.kind == RemoteFailureKind.permissionDenied;
    _retry = Timer(denied ? deniedRetryDelay : retryDelay, () {
      if (_running) _listen();
    });
  }
}
