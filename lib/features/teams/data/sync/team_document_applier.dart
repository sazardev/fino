import '../../../../core/database/app_database.dart';
import '../../../../core/sync/remote_document.dart';
import '../mappers/team_mapper.dart';
import '../remote/team_remote_mapper.dart';

/// El documento `teams/{team}` → Drift.
class TeamDocumentApplier {
  const new(this._db, this.teamId);

  final AppDatabase _db;
  final String teamId;

  String get path => '${TeamRemoteMapper.collection}/$teamId';

  /// [document] `null` = el equipo ya no existe (lo eliminaron): se borran
  /// sus datos locales. No pisa lo que tiene escrituras pendientes.
  Future<void> apply(RemoteDocument? document) => _db.transaction(() async {
    if ((await _db.outboxDao.pendingPaths()).contains(path)) return;
    if (document == null) {
      await _db.purgeTeamData(teamId);
      return;
    }
    final fields = document.fields;
    await _db.teamsDao.upsertTeam(
      TeamMapper.toCompanion(
        TeamRemoteMapper.fromFields(teamId, fields),
        adminId: TeamRemoteMapper.adminIdOf(fields),
      ),
    );
  });
}
