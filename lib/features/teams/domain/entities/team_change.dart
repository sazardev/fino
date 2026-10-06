import '../../../../core/notifications/intent/notification_intent.dart';
import '../enums/team_change_kind.dart';
import 'team.dart';
import 'team_member.dart';

/// Lo que una acción de equipos cambió, para guardarlo y notificarlo.
final class TeamChange {
  const new({
    required this.kind,
    required this.teamId,
    this.team,
    this.members = const [],
    this.removedUserIds = const [],
    this.inviteCode,
    this.previousInviteCode,
    this.notifications = const [],
  });

  static const empty = TeamChange(kind: TeamChangeKind.none, teamId: '');

  final TeamChangeKind kind;
  final String teamId;

  /// Equipo creado, modificado o eliminado.
  final Team? team;

  /// Miembros creados o modificados.
  final List<TeamMember> members;
  final List<String> removedUserIds;

  /// Con `joined`: el código con el que se entró (lo piden las reglas).
  final String? inviteCode;

  /// Con `inviteRegenerated`: el código que deja de servir.
  final String? previousInviteCode;
  final List<NotificationIntent> notifications;

  bool get isEmpty => kind == TeamChangeKind.none;
}
