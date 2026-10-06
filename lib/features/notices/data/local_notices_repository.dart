import '../../../core/database/app_database.dart';
import '../../../core/ids/id_generator.dart';
import '../../../core/notifications/inbox_write_planner.dart';
import '../../../core/time/clock.dart';
import '../domain/entities/notice_record.dart';
import '../domain/entities/notice_result.dart';
import '../domain/notices_repository.dart';
import 'mappers/notice_record_mapper.dart';
import 'remote/notice_write_planner.dart';

/// El registro de avisos leído de Drift. Cada envío se guarda primero ahí y
/// deja su lote listo en el outbox.
class LocalNoticesRepository implements NoticesRepository {
  new(this._db, this._newId, this._clock) : _inbox = InboxWritePlanner(_newId);

  final AppDatabase _db;
  final IdGenerator _newId;
  final Clock _clock;
  final InboxWritePlanner _inbox;
  static const _planner = NoticeWritePlanner();

  @override
  Stream<List<NoticeRecord>> watchSent(String senderId, String teamId) => _db
      .noticeRecordsDao
      .watchSentBy(senderId, teamId)
      .map((rows) => rows.map(NoticeRecordMapper.toDomain).toList());

  @override
  Future<Map<String, DateTime>> lastSentAt(
    String senderId,
    String teamId, {
    required DateTime since,
  }) => _db.noticeRecordsDao.lastSentAt(senderId, teamId, since: since);

  @override
  Future<void> apply(NoticeResult result) async {
    final record = result.record;
    if (record == null) return;
    await _db.transaction(() async {
      await _db.noticeRecordsDao.insertRecord(
        NoticeRecordMapper.toCompanion(record),
      );
      await _db.outboxDao.enqueueBatch(
        [..._planner.plan(result), ..._inbox.plan(result.notifications)],
        batchId: _newId(),
        now: _clock(),
      );
    });
  }
}
