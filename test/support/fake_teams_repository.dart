import 'package:fino/features/teams/domain/entities/team_summary.dart';
import 'package:fino/features/teams/domain/teams_repository.dart';

/// Teams served from memory, to [userId] only; nobody else has any.
class FakeTeamsRepository implements TeamsRepository {
  const new({this.userId = 'u1', this.teams = const []});

  final String userId;
  final List<TeamSummary> teams;

  @override
  Stream<List<TeamSummary>> watchTeamsOf(String userId) =>
      Stream.value(userId == this.userId ? teams : const []);
}
