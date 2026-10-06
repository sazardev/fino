import '../../../core/database/app_database.dart';
import '../../../core/ids/id_generator.dart';
import '../../../core/time/clock.dart';
import '../domain/entities/payout_method.dart';
import '../domain/entities/team.dart';
import '../domain/entities/team_change.dart';
import '../domain/entities/team_member.dart';
import '../domain/entities/team_roster.dart';
import '../domain/team_store.dart';
import 'mappers/payout_method_mapper.dart';
import 'mappers/team_mapper.dart';
import 'mappers/team_member_mapper.dart';
import 'remote/team_change_write_planner.dart';
import 'teams_local_writer.dart';

/// Equipos leídos de Drift. Cada acción se guarda primero ahí y deja su lote
/// listo en el outbox.
class LocalTeamStore implements TeamStore {
  new(this._db, this._newId, this._clock) : _writer = TeamsLocalWriter(_db);

  final AppDatabase _db;
  final IdGenerator _newId;
  final Clock _clock;
  final TeamsLocalWriter _writer;
  static const _planner = TeamChangeWritePlanner();

  @override
  Stream<List<TeamMember>> watchMembers(String teamId) => _db.teamsDao
      .watchMembers(teamId)
      .map((rows) => rows.map(TeamMemberMapper.toDomain).toList());

  @override
  Stream<PayoutMethod?> watchPayoutMethod(String teamId, String userId) => _db
      .teamsDao
      .watchPayoutMethod(teamId, userId)
      .map((row) => row == null ? null : PayoutMethodMapper.toDomain(row));

  @override
  Stream<Team?> watchTeam(String teamId) => _db.teamsDao
      .watchTeam(teamId)
      .map((row) => row == null ? null : TeamMapper.toDomain(row));

  @override
  Future<Team?> findTeam(String teamId) async {
    final row = await _db.teamsDao.findTeam(teamId);
    return row == null ? null : TeamMapper.toDomain(row);
  }

  @override
  Future<TeamRoster> rosterOf(String teamId) async => TeamRoster([
    for (final row in await _db.teamsDao.membersOf(teamId))
      TeamMemberMapper.toDomain(row),
  ]);

  @override
  Future<void> apply(TeamChange change, {required String actorId}) async {
    if (change.isEmpty) return;
    await _db.transaction(() async {
      await _writer.write(change, actorId: actorId);
      await _db.outboxDao.enqueueBatch(
        _planner.plan(change),
        batchId: _newId(),
        now: _clock(),
      );
    });
  }
}
