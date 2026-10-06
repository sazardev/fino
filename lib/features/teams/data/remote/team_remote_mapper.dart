import '../../../../core/sync/remote_marker.dart';
import '../../domain/entities/team.dart';

/// [Team] ↔ documento `teams/{id}`.
abstract final class TeamRemoteMapper {
  static const collection = 'teams';

  /// Un equipo nuevo tiene un solo miembro: su creador, que es el admin.
  static Map<String, Object?> toCreateFields(
    Team team, {
    required String adminId,
  }) => {
    'name': team.name,
    'adminId': adminId,
    'inviteCode': team.inviteCode,
    'memberIds': [adminId],
    'createdAt': RemoteMarker.serverTimestamp,
  };

  static Team fromFields(String id, Map<String, Object?> fields) => Team(
    id: id,
    name: fields['name']! as String,
    inviteCode: fields['inviteCode']! as String,
    createdAt: fields['createdAt']! as DateTime,
  );

  static String adminIdOf(Map<String, Object?> fields) =>
      fields['adminId']! as String;

  static List<String> memberIdsOf(Map<String, Object?> fields) =>
      (fields['memberIds']! as List<Object?>).cast<String>();
}
