import '../entities/live_debts.dart';
import 'team_failure_reason.dart';

/// Se lanza cuando una acción rompe una regla de equipos del SPEC.
final class TeamFailure implements Exception {
  const new(this.reason, {this.blocking});

  final TeamFailureReason reason;

  /// Con `hasLiveDebts`: qué deudas impiden la acción.
  final LiveDebts? blocking;

  @override
  String toString() => 'TeamFailure(${reason.name})';
}
