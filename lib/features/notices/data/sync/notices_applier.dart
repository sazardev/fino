import '../../../../core/sync/pull/scoped_collection_applier.dart';
import '../../../../core/sync/remote_document.dart';
import '../../domain/entities/notice_content.dart';
import '../../domain/entities/notice_record.dart';
import '../../domain/enums/notice_template.dart';
import '../mappers/notice_record_mapper.dart';

/// `teams/{team}/notices` (los que yo envié) → Drift.
class NoticesApplier extends ScopedCollectionApplier {
  const new(super.db, this.teamId, this.senderId);

  final String teamId;
  final String senderId;

  @override
  Future<void> upsert(RemoteDocument document) {
    final fields = document.fields;
    final template = fields['template'] as String?;
    return db.noticeRecordsDao.insertRecord(
      NoticeRecordMapper.toCompanion(
        NoticeRecord(
          id: document.id,
          senderId: fields['senderId']! as String,
          teamId: teamId,
          recipientIds: (fields['recipientIds']! as List<Object?>)
              .cast<String>(),
          content: template != null
              ? NoticeContent.fromTemplate(
                  NoticeTemplate.values.byName(template),
                )
              : NoticeContent.custom(fields['text']! as String),
          sentAt: fields['sentAt']! as DateTime,
        ),
      ),
    );
  }

  @override
  Future<void> delete(String id) => db.noticeRecordsDao.deleteRecord(id);

  @override
  Future<Set<String>> localIds() =>
      db.noticeRecordsDao.idsSentBy(senderId, teamId);

  @override
  String pathOf(String id) => 'teams/$teamId/notices/$id';
}
