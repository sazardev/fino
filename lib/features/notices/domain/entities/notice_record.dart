import 'package:freezed_annotation/freezed_annotation.dart';

import 'notice_content.dart';

part 'notice_record.freezed.dart';

/// Registro del acreedor: qué avisó, a quién y cuándo (SPEC A5).
@freezed
abstract class NoticeRecord with _$NoticeRecord {
  const factory({
    required String id,
    required String senderId,
    required String teamId,
    required List<String> recipientIds,
    required NoticeContent content,
    required DateTime sentAt,
  }) = _NoticeRecord;
}
