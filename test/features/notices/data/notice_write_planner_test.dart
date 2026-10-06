import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/features/notices/data/remote/notice_write_planner.dart';
import 'package:fino/features/notices/domain/entities/notice_content.dart';
import 'package:fino/features/notices/domain/entities/notice_record.dart';
import 'package:fino/features/notices/domain/entities/notice_result.dart';
import 'package:fino/features/notices/domain/enums/notice_template.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../orders/domain/support/order_fixtures.dart';

void main() {
  NoticeResult result(NoticeContent content) => NoticeResult(
    notifications: const [],
    skipped: const [],
    record: NoticeRecord(
      id: 'n1',
      senderId: 'omar',
      teamId: 't1',
      recipientIds: const ['ana', 'beto'],
      content: content,
      sentAt: t0,
    ),
  );

  test('a custom notice is logged with its text', () {
    final write = const NoticeWritePlanner()
        .plan(result(NoticeContent.custom('ya paguen')))
        .single;

    expect(write.path, 'teams/t1/notices/n1');
    expect(write.operation, OutboxOperation.create);
    expect(write.fields, {
      'senderId': 'omar',
      'recipientIds': ['ana', 'beto'],
      'text': 'ya paguen',
      'sentAt': RemoteMarker.serverTimestamp,
    });
  });

  test('a template notice is logged by template name', () {
    final write = const NoticeWritePlanner()
        .plan(result(NoticeContent.fromTemplate(NoticeTemplate.askIfPaid)))
        .single;

    expect(write.fields['template'], 'askIfPaid');
    expect(write.fields, isNot(contains('text')));
  });

  test('nothing is logged when everyone was in cooldown', () {
    const nobody = NoticeResult(notifications: [], skipped: [], record: null);

    expect(const NoticeWritePlanner().plan(nobody), isEmpty);
  });
}
