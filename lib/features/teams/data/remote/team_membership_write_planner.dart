import '../../../../core/database/outbox_operation.dart';
import '../../../../core/sync/remote_array_op.dart';
import '../../../../core/sync/remote_write.dart';
import '../../domain/entities/team_change.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/enums/team_role.dart';
import 'payout_method_remote_mapper.dart';
import 'team_member_remote_mapper.dart';
import 'team_remote_mapper.dart';

/// Escrituras de UN lote para los miembros: entrar, salir, expulsar, pasar
/// el rol de admin, su perfil y su método de cobro.
///
/// Las reglas exigen que el miembro y `memberIds` del equipo viajen juntos.
class TeamMembershipWritePlanner {
  const new();

  /// Entrar con un código: el miembro y su alta en `memberIds`.
  List<RemoteWrite> planJoin(TeamChange change, {required String inviteCode}) {
    final member = change.members.single;
    return [
      TeamMemberRemoteMapper.createWrite(member, inviteCode: inviteCode),
      RemoteWrite(
        collection: TeamRemoteMapper.collection,
        id: member.teamId,
        operation: OutboxOperation.update,
        fields: {
          'memberIds': RemoteArrayOp.union([member.userId]),
        },
      ),
    ];
  }

  /// Salir o expulsar: se borra al miembro y se le quita de `memberIds`.
  List<RemoteWrite> planRemoveMembers(
    TeamChange change, {
    required String teamId,
  }) => [
    for (final userId in change.removedUserIds)
      RemoteWrite(
        collection: TeamMemberRemoteMapper.collection(teamId),
        id: userId,
        operation: OutboxOperation.delete,
      ),
    RemoteWrite(
      collection: TeamRemoteMapper.collection,
      id: teamId,
      operation: OutboxOperation.update,
      fields: {'memberIds': RemoteArrayOp.remove(change.removedUserIds)},
    ),
  ];

  /// Pasar el rol de admin: el equipo apunta al nuevo y los roles lo siguen.
  List<RemoteWrite> planTransferAdmin(TeamChange change) {
    final teamId = change.members.first.teamId;
    final newAdmin = change.members.firstWhere(
      (member) => member.role == TeamRole.admin,
    );
    return [
      RemoteWrite(
        collection: TeamRemoteMapper.collection,
        id: teamId,
        operation: OutboxOperation.update,
        fields: {'adminId': newAdmin.userId},
      ),
      for (final member in change.members)
        RemoteWrite(
          collection: TeamMemberRemoteMapper.collection(teamId),
          id: member.userId,
          operation: OutboxOperation.update,
          fields: TeamMemberRemoteMapper.toRoleFields(member),
        ),
    ];
  }

  /// Configurar o reemplazar el método de cobro propio.
  List<RemoteWrite> planPayoutMethod(TeamChange change) {
    final member = change.members.single;
    return [
      RemoteWrite(
        collection: PayoutMethodRemoteMapper.collection(
          member.teamId,
          member.userId,
        ),
        id: PayoutMethodRemoteMapper.documentId,
        operation: OutboxOperation.set,
        fields: PayoutMethodRemoteMapper.toFields(member.payoutMethod!),
      ),
    ];
  }

  /// Refrescar nombre y foto de Google (SPEC U2).
  List<RemoteWrite> planProfile(TeamMember member) => [
    RemoteWrite(
      collection: TeamMemberRemoteMapper.collection(member.teamId),
      id: member.userId,
      operation: OutboxOperation.update,
      fields: TeamMemberRemoteMapper.toProfileFields(member),
    ),
  ];
}
