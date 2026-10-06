import 'entities/team_summary.dart';

/// The teams a person belongs to.
abstract interface class TeamsRepository {
  /// [userId]'s teams by name, now and on every change.
  Stream<List<TeamSummary>> watchTeamsOf(String userId);
}
