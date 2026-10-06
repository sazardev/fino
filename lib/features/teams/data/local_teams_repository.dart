import '../domain/entities/team_summary.dart';
import '../domain/teams_repository.dart';
import 'daos/teams_dao.dart';
import 'mappers/team_summary_mapper.dart';

/// Teams read from the local database, the source of truth for the UI.
class LocalTeamsRepository implements TeamsRepository {
  const new(this._dao);

  final TeamsDao _dao;

  @override
  Stream<List<TeamSummary>> watchTeamsOf(String userId) => _dao
      .watchMembershipsOf(userId)
      .map((rows) => rows.map(TeamSummaryMapper.toDomain).toList());
}
