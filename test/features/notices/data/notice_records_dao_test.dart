import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/features/notices/data/mappers/notice_record_mapper.dart';
import 'package:fino/features/notices/domain/entities/notice_content.dart';
import 'package:fino/features/notices/domain/entities/notice_record.dart';
import 'package:fino/features/notices/domain/enums/notice_template.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  final now = DateTime.utc(2026, 10, 6, 15);

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  NoticeRecord record(
    String id,
    DateTime sentAt,
    List<String> to, {
    NoticeContent? content,
    String sender = 'omar',
    String teamId = 't1',
  }) => NoticeRecord(
    id: id,
    senderId: sender,
    teamId: teamId,
    recipientIds: to,
    content: content ?? NoticeContent.custom('ya paguen'),
    sentAt: sentAt,
  );

  Future<void> save(NoticeRecord r) =>
      db.noticeRecordsDao.insertRecord(NoticeRecordMapper.toCompanion(r));

  test('custom text and templates both round-trip', () async {
    final custom = record('n1', now, ['ana', 'beto']);
    final template = record('n2', now.add(const Duration(minutes: 1)), [
      'ana',
    ], content: NoticeContent.fromTemplate(NoticeTemplate.askIfPaid));
    await save(custom);
    await save(template);

    final rows = await db.noticeRecordsDao.watchSentBy('omar', 't1').first;

    expect(rows.map(NoticeRecordMapper.toDomain).toList(), [template, custom]);
  });

  test('last notice per recipient feeds the hourly limit (A3)', () async {
    await save(
      record('n1', now.subtract(const Duration(minutes: 90)), ['ana']),
    );
    await save(
      record('n2', now.subtract(const Duration(minutes: 30)), ['ana', 'beto']),
    );
    await save(
      record('n3', now.subtract(const Duration(minutes: 10)), ['beto']),
    );
    await save(
      record('n4', now.subtract(const Duration(minutes: 5)), [
        'cris',
      ], sender: 'ana'),
    );
    await save(
      record('n5', now.subtract(const Duration(minutes: 5)), [
        'cris',
      ], teamId: 't2'),
    );

    final last = await db.noticeRecordsDao.lastSentAt(
      'omar',
      't1',
      since: now.subtract(const Duration(hours: 1)),
    );

    expect(last, {
      'ana': now.subtract(const Duration(minutes: 30)),
      'beto': now.subtract(const Duration(minutes: 10)),
    });
  });

  test('deleting a team removes its records', () async {
    await save(record('n1', now, ['ana']));
    await save(record('n2', now, ['ana'], teamId: 't2'));

    await db.noticeRecordsDao.deleteTeamRecords('t1');

    expect(await db.noticeRecordsDao.watchSentBy('omar', 't1').first, isEmpty);
    expect(
      await db.noticeRecordsDao.watchSentBy('omar', 't2').first,
      isNotEmpty,
    );
  });
}
