import '../enums/team_role.dart';
import 'team_member.dart';

/// Los miembros de un equipo y las preguntas que se les hacen.
final class TeamRoster {
  const new(this.members);

  final List<TeamMember> members;

  int get size => members.length;

  Set<String> get memberIds => {for (final m in members) m.userId};

  TeamMember? memberOf(String userId) {
    for (final member in members) {
      if (member.userId == userId) return member;
    }
    return null;
  }

  bool isMember(String userId) => memberOf(userId) != null;

  bool isAdmin(String userId) => memberOf(userId)?.role == TeamRole.admin;

  Iterable<TeamMember> get admins =>
      members.where((member) => member.role == TeamRole.admin);
}
