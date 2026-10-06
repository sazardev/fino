import 'package:freezed_annotation/freezed_annotation.dart';

/// Agrega ([union] = true) o quita elementos de un campo lista sin pisar lo
/// que otros escribieron al mismo tiempo (`arrayUnion` / `arrayRemove`).
@immutable
final class RemoteArrayOp {
  const new union(this.values) : union = true;

  const new remove(this.values) : union = false;

  final bool union;
  final List<Object?> values;
}
