import 'package:freezed_annotation/freezed_annotation.dart';

import '../remote_failure.dart';

/// Un lote que el servidor rechazó para siempre (las reglas, no la red): se
/// descarta y lo local debe volver a lo que dice el servidor.
@immutable
final class OutboxRejection {
  const new({
    required this.batchId,
    required this.paths,
    required this.failure,
  });

  final String batchId;

  /// Documentos que tocaba el lote.
  final List<String> paths;
  final RemoteFailure failure;

  /// Equipos afectados (`teams/{id}/…`), para volver a bajar su estado.
  Set<String> get teamIds => {
    for (final path in paths)
      if (path.startsWith('teams/')) path.split('/')[1],
  };
}
