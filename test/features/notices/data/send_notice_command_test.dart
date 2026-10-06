import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/notices/data/local_notice_audience.dart';
import 'package:fino/features/notices/data/local_notices_repository.dart';
import 'package:fino/features/notices/domain/commands/send_notice_command.dart';
import 'package:fino/features/notices/domain/entities/notice_content.dart';
import 'package:fino/features/notices/domain/enums/notice_template.dart';
import 'package:fino/features/notices/domain/failures/notice_failure_reason.dart';
import 'package:fino/features/orders/data/mappers/debt_mapper.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/teams/domain/enums/team_role.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../orders/domain/support/order_fixtures.dart';

void main() {
  late AppDatabase db;
  late SendNoticeCommand send;
  var now = DateTime.utc(2026, 10, 6, 15);
  var n = 0;
  String newId() => 'id${++n}';

  setUp(() async {
    now = DateTime.utc(2026, 10, 6, 15);
    db = AppDatabase(NativeDatabase.memory());
    send = SendNoticeCommand(
      LocalNoticesRepository(db, newId, () => now),
      LocalNoticeAudience(db),
      newId,
      () => now,
    );
    for (final user in ['omar', 'ana', 'beto', 'cris']) {
      await db.teamsDao.upsertMember(
        TeamMembersCompanion.insert(
          teamId: 't1',
          userId: user,
          role: TeamRole.member,
          joinedAt: now,
          displayName: user,
        ),
      );
    }
    await db.debtsDao.upsertDebts([
      for (final (id, debtor, cents) in [
        ('d1', 'ana', 6000),
        ('d2', 'ana', 4000),
        ('d3', 'beto', 5000),
      ])
        DebtMapper.toCompanion(
          buildDebt(id: id, debtorId: debtor, amount: Money(cents)),
        ),
      DebtMapper.toCompanion(
        buildDebt(id: 'd4', debtorId: 'cris', status: DebtStatus.confirmed),
      ),
    ]);
  });
  tearDown(() => db.close());

  Future<List<String>> debtors() async =>
      (await LocalNoticeAudience(db).owedTo('omar', 't1')).keys.toList()
        ..sort();

  test('audience: who owes me and how much (A1, A4)', () async {
    final owed = await LocalNoticeAudience(db).owedTo('omar', 't1');

    expect(owed, {'ana': const Money(10000), 'beto': const Money(5000)});
    expect(await debtors(), ['ana', 'beto']);
    expect(await LocalNoticeAudience(db).memberIds('t1'), {
      'omar',
      'ana',
      'beto',
      'cris',
    });
  });

  test('a notice is recorded and queued with what each one owes', () async {
    final result = await send(
      senderId: 'omar',
      teamId: 't1',
      recipientIds: ['ana', 'beto', 'cris'],
      content: NoticeContent.custom('ya paguen'),
    );

    expect(result.notifications, hasLength(3));
    final byRecipient = {
      for (final i in result.notifications) i.recipientId: i,
    };
    expect(byRecipient['ana']!.amount, const Money(10000));
    expect(byRecipient['cris']!.amount, isNull);
    expect(byRecipient['ana']!.kind, NotificationKind.notice);

    final sent = await LocalNoticesRepository(
      db,
      newId,
      () => now,
    ).watchSent('omar', 't1').first;
    expect(sent.single.recipientIds, ['ana', 'beto', 'cris']);
    final entries = await db.select(db.outboxEntries).get();
    expect(entries.map((e) => e.entity), contains('teams/t1/notices'));
    expect(entries.where((e) => e.entity.startsWith('users/')), hasLength(3));
    expect(entries.map((e) => e.batchId).toSet(), hasLength(1));
  });

  test('the hourly limit skips who was warned recently (A3)', () async {
    await send(
      senderId: 'omar',
      teamId: 't1',
      recipientIds: ['ana'],
      content: NoticeContent.fromTemplate(NoticeTemplate.askIfPaid),
    );
    now = now.add(const Duration(minutes: 30));

    final result = await send(
      senderId: 'omar',
      teamId: 't1',
      recipientIds: ['ana', 'beto'],
      content: NoticeContent.custom('otra vez'),
    );

    expect(result.notifications.map((i) => i.recipientId), ['beto']);
    expect(result.skipped.single.userId, 'ana');
    expect(result.skipped.single.retryAt, DateTime.utc(2026, 10, 6, 16));

    now = now.add(const Duration(minutes: 31));
    final later = await send(
      senderId: 'omar',
      teamId: 't1',
      recipientIds: ['ana'],
      content: NoticeContent.custom('ya'),
    );
    expect(later.notifications, hasLength(1));
  });

  test('when everyone is waiting nothing is queued', () async {
    await send(
      senderId: 'omar',
      teamId: 't1',
      recipientIds: ['ana'],
      content: NoticeContent.custom('a'),
    );
    final before = (await db.select(db.outboxEntries).get()).length;

    final result = await send(
      senderId: 'omar',
      teamId: 't1',
      recipientIds: ['ana'],
      content: NoticeContent.custom('b'),
    );

    expect(result.record, isNull);
    expect((await db.select(db.outboxEntries).get()).length, before);
  });

  test('strangers cannot be warned', () async {
    await expectLater(
      send(
        senderId: 'omar',
        teamId: 't1',
        recipientIds: ['zoe'],
        content: NoticeContent.custom('hola'),
      ),
      throwsA(
        isA<Object>().having(
          (e) => e.toString(),
          'reason',
          contains(NoticeFailureReason.recipientNotMember.name),
        ),
      ),
    );
  });
}
