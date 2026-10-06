import 'package:freezed_annotation/freezed_annotation.dart';

import 'remote_change.dart';

/// Lo que cambió en una colección escuchada.
@immutable
final class RemoteSnapshot {
  const new(this.changes, {required this.isInitial});

  /// La primera instantánea trae TODOS los documentos (como `added`): lo que
  /// falte allí ya no existe en el servidor.
  final List<RemoteChange> changes;
  final bool isInitial;
}
