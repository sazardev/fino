import 'notice_failure_reason.dart';

/// Se lanza cuando un aviso rompe una regla del SPEC.
final class NoticeFailure implements Exception {
  const new(this.reason);

  final NoticeFailureReason reason;

  @override
  String toString() => 'NoticeFailure(${reason.name})';
}
