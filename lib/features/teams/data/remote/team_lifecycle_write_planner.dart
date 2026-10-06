import '../../../../core/database/outbox_operation.dart';
import '../../../../core/sync/remote_write.dart';
import '../../domain/entities/team_change.dart';
import 'invite_remote_mapper.dart';
import 'team_member_remote_mapper.dart';
import 'team_remote_mapper.dart';

/// Escrituras de UN lote para el ciclo de vida del equipo: crearlo, cambiar
/// su código y eliminarlo.
class TeamLifecycleWritePlanner {
  const new();

  /// Equipo nuevo: él, su creador como admin, y su código de invitación.
  List<RemoteWrite> planCreate(TeamChange change) {
    final team = change.team!;
    final creator = change.members.single;
    return [
      RemoteWrite(
        collection: TeamRemoteMapper.collection,
        id: team.id,
        operation: OutboxOperation.create,
        fields: TeamRemoteMapper.toCreateFields(team, adminId: creator.userId),
      ),
      TeamMemberRemoteMapper.createWrite(creator),
      InviteRemoteMapper.create(
        code: team.inviteCode,
        teamId: team.id,
        teamName: team.name,
      ),
    ];
  }

  /// Código nuevo: el viejo deja de servir.
  List<RemoteWrite> planRegenerateCode(
    TeamChange change, {
    required String previousCode,
  }) {
    final team = change.team!;
    return [
      RemoteWrite(
        collection: TeamRemoteMapper.collection,
        id: team.id,
        operation: OutboxOperation.update,
        fields: {'inviteCode': team.inviteCode},
      ),
      InviteRemoteMapper.delete(previousCode),
      InviteRemoteMapper.create(
        code: team.inviteCode,
        teamId: team.id,
        teamName: team.name,
      ),
    ];
  }

  /// Eliminar el equipo: se limpian los miembros (así los demás dispositivos
  /// lo notan) y lo demás queda inalcanzable sin el equipo.
  List<RemoteWrite> planDelete(TeamChange change) {
    final team = change.team!;
    return [
      for (final userId in change.removedUserIds)
        RemoteWrite(
          collection: TeamMemberRemoteMapper.collection(team.id),
          id: userId,
          operation: OutboxOperation.delete,
        ),
      RemoteWrite(
        collection: TeamRemoteMapper.collection,
        id: team.id,
        operation: OutboxOperation.delete,
      ),
      InviteRemoteMapper.delete(team.inviteCode),
    ];
  }
}
