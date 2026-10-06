import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../tables/notice_records.dart';

part 'notice_records_dao.g.dart';

/// Consultas locales del registro de avisos enviados.
@DriftAccessor(tables: [NoticeRecords])
class NoticeRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$NoticeRecordsDaoMixin {
  new(super.attachedDatabase);

  Future<void> insertRecord(NoticeRecordsCompanion record) =>
      into(noticeRecords).insertOnConflictUpdate(record);

  Stream<List<NoticeRecordRow>> watchSentBy(String senderId, String teamId) =>
      (select(noticeRecords)
            ..where(
              (n) => n.senderId.equals(senderId) & n.teamId.equals(teamId),
            )
            ..orderBy([(n) => OrderingTerm.desc(n.sentAt)]))
          .watch();

  /// El último aviso que [senderId] le mandó a cada destinatario desde [since]
  /// (alimenta el límite de frecuencia, SPEC A3).
  Future<Map<String, DateTime>> lastSentAt(
    String senderId,
    String teamId, {
    required DateTime since,
  }) async {
    final rows =
        await (select(noticeRecords)..where(
              (n) =>
                  n.senderId.equals(senderId) &
                  n.teamId.equals(teamId) &
                  n.sentAt.isBiggerOrEqualValue(since),
            ))
            .get();
    final last = <String, DateTime>{};
    for (final row in rows) {
      for (final recipient in row.recipientIds) {
        final seen = last[recipient];
        if (seen == null || row.sentAt.isAfter(seen)) {
          last[recipient] = row.sentAt.toUtc();
        }
      }
    }
    return last;
  }

  Future<Set<String>> idsSentBy(String senderId, String teamId) async => {
    for (final row
        in await (select(noticeRecords)..where(
              (n) => n.senderId.equals(senderId) & n.teamId.equals(teamId),
            ))
            .get())
      row.id,
  };

  Future<void> deleteRecord(String id) =>
      (delete(noticeRecords)..where((n) => n.id.equals(id))).go();

  Future<void> deleteTeamRecords(String teamId) =>
      (delete(noticeRecords)..where((n) => n.teamId.equals(teamId))).go();
}
