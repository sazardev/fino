import '../../../../core/database/app_database.dart';
import '../../domain/entities/team_summary.dart';
import '../../domain/enums/team_role.dart';
import 'team_mapper.dart';

/// Fila de equipo + rol + conteo ↔ [TeamSummary].
abstract final class TeamSummaryMapper {
  static TeamSummary toDomain((TeamRow, TeamRole, int) membership) {
    final (team, role, memberCount) = membership;
    return TeamSummary(
      team: TeamMapper.toDomain(team),
      role: role,
      memberCount: memberCount,
    );
  }
}
