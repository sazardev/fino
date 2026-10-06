import 'order_failure_reason.dart';

/// Se lanza cuando una acción rompe una regla del SPEC.
final class OrderFailure implements Exception {
  const new(this.reason);

  final OrderFailureReason reason;

  @override
  String toString() => 'OrderFailure(${reason.name})';
}
