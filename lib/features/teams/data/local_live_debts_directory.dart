import '../../../core/database/app_database.dart';
import '../domain/entities/live_debts.dart';
import '../domain/live_debts_directory.dart';

/// Deudas vivas contadas desde Drift.
class LocalLiveDebtsDirectory implements LiveDebtsDirectory {
  const new(this._db);

  final AppDatabase _db;

  @override
  Future<LiveDebts> ofUser(String userId, String teamId) async {
    final counts = await _db.debtsDao.liveCounts(userId, teamId);
    return LiveDebts(asDebtor: counts.asDebtor, asCreditor: counts.asCreditor);
  }

  @override
  Future<LiveDebts> ofTeam(String teamId) async =>
      LiveDebts(asDebtor: await _db.debtsDao.liveCountOfTeam(teamId));
}
