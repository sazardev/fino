import 'package:freezed_annotation/freezed_annotation.dart';

import 'remote_filter_op.dart';

/// Un filtro de consulta. Las reglas de Firestore no filtran: una consulta
/// solo se acepta si ya restringe a lo que el usuario puede leer.
@immutable
final class RemoteFilter {
  const new(this.field, this.op, this.value);

  const new equal(String field, Object? value)
    : this(field, RemoteFilterOp.equal, value);

  const new arrayContains(String field, Object? value)
    : this(field, RemoteFilterOp.arrayContains, value);

  final String field;
  final RemoteFilterOp op;
  final Object? value;
}
