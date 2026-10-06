import 'remote_failure_kind.dart';

/// Un error del servidor ya clasificado, sin depender del SDK.
final class RemoteFailure implements Exception {
  const new(this.kind, [this.message = '']);

  final RemoteFailureKind kind;
  final String message;

  /// Vale la pena reintentar la misma operación más tarde.
  bool get isTransient =>
      kind == RemoteFailureKind.unavailable ||
      kind == RemoteFailureKind.unauthenticated ||
      kind == RemoteFailureKind.other;

  @override
  String toString() => 'RemoteFailure(${kind.name}: $message)';
}
