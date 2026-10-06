import 'package:freezed_annotation/freezed_annotation.dart';

import 'outbox_rejection.dart';

/// Lo que pasó en una pasada del outbox.
@immutable
final class FlushResult {
  const new({this.committed = 0, this.rejections = const [], this.retryAt});

  /// Lotes enviados y confirmados por el servidor.
  final int committed;

  /// Lotes descartados por rechazo permanente.
  final List<OutboxRejection> rejections;

  /// Cuándo reintentar si la cola quedó esperando (red caída o espera por
  /// reintento); `null` si quedó vacía.
  final DateTime? retryAt;
}
