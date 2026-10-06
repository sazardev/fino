import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/notice_content.dart';
import '../../domain/entities/notice_record.dart';

/// Fila local ↔ [NoticeRecord].
abstract final class NoticeRecordMapper {
  static NoticeRecord toDomain(NoticeRecordRow row) => NoticeRecord(
    id: row.id,
    senderId: row.senderId,
    teamId: row.teamId,
    recipientIds: row.recipientIds,
    content: row.template != null
        ? NoticeContent.fromTemplate(row.template!)
        : NoticeContent.custom(row.customText ?? ''),
    sentAt: row.sentAt.toUtc(),
  );

  static NoticeRecordsCompanion toCompanion(NoticeRecord record) =>
      NoticeRecordsCompanion.insert(
        id: record.id,
        teamId: record.teamId,
        senderId: record.senderId,
        recipientIds: record.recipientIds,
        template: Value(record.content.template),
        customText: Value(record.content.text),
        sentAt: record.sentAt,
      );
}
