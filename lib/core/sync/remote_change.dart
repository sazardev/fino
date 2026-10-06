import 'package:freezed_annotation/freezed_annotation.dart';

import 'remote_change_kind.dart';
import 'remote_document.dart';

/// Un documento que apareció, cambió o desapareció en el servidor.
@immutable
final class RemoteChange {
  const new(this.kind, this.document);

  final RemoteChangeKind kind;

  /// En `removed` solo importa su ruta.
  final RemoteDocument document;
}
