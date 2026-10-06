import '../../../../core/database/app_database.dart';
import '../../domain/entities/team.dart';

/// Fila local ↔ [Team].
abstract final class TeamMapper {
  static Team toDomain(TeamRow row) => Team(
    id: row.id,
    name: row.name,
    inviteCode: row.inviteCode,
    createdAt: row.createdAt.toUtc(),
  );

  /// [adminId] vive en el equipo remoto y no en la entidad: el rol de cada
  /// miembro ya lo dice.
  static TeamsCompanion toCompanion(Team team, {required String adminId}) =>
      TeamsCompanion.insert(
        id: team.id,
        name: team.name,
        adminId: adminId,
        inviteCode: team.inviteCode,
        createdAt: team.createdAt,
      );
}
