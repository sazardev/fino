import '../../domain/entities/team_summary.dart';
import '../../domain/enums/team_role.dart';

/// "Admin · 5 miembros": what a team's tile says under its name.
abstract final class TeamSummarySubtitle {
  const new _();

  static String of(TeamSummary summary) {
    final role = summary.role == TeamRole.admin ? 'Admin' : 'Miembro';
    final count = summary.memberCount;
    return '$role · $count ${count == 1 ? 'miembro' : 'miembros'}';
  }
}
