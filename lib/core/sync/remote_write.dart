import 'package:freezed_annotation/freezed_annotation.dart';

import '../database/outbox_operation.dart';

/// Una escritura pendiente hacia Firestore, sin depender del SDK.
///
/// Los valores de [fields] son `null`, `bool`, `int`, `double`, `String`,
/// `DateTime`, `List`, `Map<String, Object?>`, un `RemoteMarker` o un
/// `RemoteArrayOp`. Todas las escrituras de una misma acción de negocio
/// comparten lote (`batchId` del outbox) y viajan en un solo batch atómico.
@immutable
final class RemoteWrite {
  const new({
    required this.collection,
    required this.id,
    required this.operation,
    this.fields = const {},
  });

  /// Ruta de la colección, p. ej. `teams/t1/debts`.
  final String collection;
  final String id;
  final OutboxOperation operation;
  final Map<String, Object?> fields;

  String get path => '$collection/$id';
}
