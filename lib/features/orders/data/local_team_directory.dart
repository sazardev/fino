import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/entities/payout_snapshot.dart';
import '../domain/team_directory.dart';

/// El directorio del equipo leído de Drift.
class LocalTeamDirectory implements TeamDirectory {
  const new(this._db);

  final AppDatabase _db;

  @override
  Future<Set<String>> memberIds(String teamId) async => {
    for (final row in await (_db.select(
      _db.teamMembers,
    )..where((m) => m.teamId.equals(teamId))).get())
      row.userId,
  };

  @override
  Future<PayoutSnapshot?> payoutOf(String teamId, String userId) async {
    final row =
        await (_db.select(_db.payoutMethods)
              ..where((p) => p.teamId.equals(teamId) & p.userId.equals(userId)))
            .getSingleOrNull();
    if (row == null) return null;
    return PayoutSnapshot(
      bankName: row.bankName,
      last4: row.number.substring(row.number.length - 4),
    );
  }
}
