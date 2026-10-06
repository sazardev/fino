import '../../../../core/database/outbox_operation.dart';
import '../../../../core/sync/remote_marker.dart';
import '../../../../core/sync/remote_write.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/enums/team_role.dart';

/// [TeamMember] ↔ documento `teams/{team}/members/{uid}`.
abstract final class TeamMemberRemoteMapper {
  static String collection(String teamId) => 'teams/$teamId/members';

  /// [inviteCode] va solo cuando alguien entra con un código (SPEC E2).
  static Map<String, Object?> toCreateFields(
    TeamMember member, {
    String? inviteCode,
  }) => {
    'userId': member.userId,
    'role': member.role.name,
    'joinedAt': RemoteMarker.serverTimestamp,
    'displayName': member.displayName,
    'photoUrl': ?member.photoUrl,
    'inviteCode': ?inviteCode,
  };

  static RemoteWrite createWrite(TeamMember member, {String? inviteCode}) =>
      RemoteWrite(
        collection: collection(member.teamId),
        id: member.userId,
        operation: OutboxOperation.create,
        fields: toCreateFields(member, inviteCode: inviteCode),
      );

  /// Nombre y foto de Google (SPEC U2).
  static Map<String, Object?> toProfileFields(TeamMember member) => {
    'displayName': member.displayName,
    'photoUrl': member.photoUrl ?? RemoteMarker.fieldDelete,
  };

  static Map<String, Object?> toRoleFields(TeamMember member) => {
    'role': member.role.name,
  };

  static TeamMember fromFields(String teamId, Map<String, Object?> fields) =>
      TeamMember(
        teamId: teamId,
        userId: fields['userId']! as String,
        role: TeamRole.values.byName(fields['role']! as String),
        joinedAt: fields['joinedAt']! as DateTime,
        displayName: fields['displayName']! as String,
        photoUrl: fields['photoUrl'] as String?,
      );
}
