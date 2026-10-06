import '../../../core/database/app_database.dart';
import '../../../core/money/money.dart';
import '../domain/notice_audience.dart';

/// Miembros y deudas vivas leídos de Drift.
class LocalNoticeAudience implements NoticeAudience {
  const new(this._db);

  final AppDatabase _db;

  @override
  Future<Set<String>> memberIds(String teamId) async => {
    for (final row in await _db.teamsDao.membersOf(teamId)) row.userId,
  };

  @override
  Future<Map<String, Money>> owedTo(String senderId, String teamId) async {
    final owed = <String, Money>{};
    final rows = await _db.debtsDao.liveDebtsOfCreditor(senderId, teamId);
    for (final debt in rows) {
      owed.update(
        debt.debtorId,
        (total) => total + Money(debt.amountCents),
        ifAbsent: () => Money(debt.amountCents),
      );
    }
    return owed;
  }
}
