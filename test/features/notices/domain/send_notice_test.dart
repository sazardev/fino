import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/features/notices/domain/entities/notice_content.dart';
import 'package:fino/features/notices/domain/entities/notice_result.dart';
import 'package:fino/features/notices/domain/entities/skipped_recipient.dart';
import 'package:fino/features/notices/domain/enums/notice_template.dart';
import 'package:fino/features/notices/domain/failures/notice_failure.dart';
import 'package:fino/features/notices/domain/failures/notice_failure_reason.dart';
import 'package:fino/features/notices/domain/use_cases/send_notice.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../orders/domain/support/order_fixtures.dart';

Matcher throwsNotice(NoticeFailureReason reason) =>
    throwsA(isA<NoticeFailure>().having((e) => e.reason, 'reason', reason));

void main() {
  final members = {'omar', 'ana', 'beto', 'cris'};

  NoticeResult Function() send({
    String sender = 'omar',
    List<String> recipients = const ['ana', 'beto'],
    NoticeContent? content,
    Map<String, Money> owed = const {},
    Map<String, DateTime> lastSent = const {},
  }) =>
      () => SendNotice(sequentialIds())(
        senderId: sender,
        teamId: 't1',
        memberIds: members,
        recipientIds: recipients,
        content: content ?? NoticeContent.custom('ya paguen'),
        owedByRecipient: owed,
        lastSentAt: lastSent,
        now: t0,
      );

  test('notifies everyone, with what they owe when they owe (A4)', () {
    final result = send(owed: {'ana': pesos(120)})();

    final forAna = result.notifications.first;
    expect(forAna.kind, NotificationKind.notice);
    expect(forAna.recipientId, 'ana');
    expect(forAna.note, 'ya paguen');
    expect(forAna.amount, pesos(120));
    expect(forAna.target, const NotificationTarget.pay('omar'));
    final forBeto = result.notifications.last;
    expect(forBeto.amount, isNull);
    expect(forBeto.target, const NotificationTarget.team('t1'));
    expect(result.skipped, isEmpty);
    expect(result.record!.recipientIds, ['ana', 'beto']);
    expect(result.record!.senderId, 'omar');
  });

  test('a template travels by key, not as text', () {
    final result = send(
      content: NoticeContent.fromTemplate(NoticeTemplate.askIfPaid),
    )();

    expect(result.notifications.first.templateKey, 'askIfPaid');
    expect(result.notifications.first.note, isNull);
  });

  test('skips who got a notice less than an hour ago (A3)', () {
    final recent = t0.subtract(const Duration(minutes: 30));
    final old = t0.subtract(const Duration(hours: 2));

    final result = send(lastSent: {'ana': recent, 'beto': old})();

    expect(result.notifications.map((n) => n.recipientId), ['beto']);
    expect(result.skipped, [
      SkippedRecipient('ana', recent.add(const Duration(hours: 1))),
    ]);
    expect(result.record!.recipientIds, ['beto']);
  });

  test('exactly one hour later is allowed again', () {
    final result = send(
      recipients: const ['ana'],
      lastSent: {'ana': t0.subtract(const Duration(hours: 1))},
    )();

    expect(result.notifications, hasLength(1));
  });

  test('when everyone is waiting nothing is recorded', () {
    final result = send(recipients: const ['ana'], lastSent: {'ana': t0})();

    expect(result.notifications, isEmpty);
    expect(result.record, isNull);
  });

  test('repeated recipients receive one notice', () {
    final result = send(recipients: const ['ana', 'ana'])();

    expect(result.notifications, hasLength(1));
  });

  test('rejects strangers, self, nobody and non-member senders', () {
    expect(
      send(recipients: const ['zoe']),
      throwsNotice(NoticeFailureReason.recipientNotMember),
    );
    expect(
      send(recipients: const ['omar']),
      throwsNotice(NoticeFailureReason.cannotNoticeSelf),
    );
    expect(
      send(recipients: const []),
      throwsNotice(NoticeFailureReason.noRecipients),
    );
    expect(
      send(sender: 'zoe'),
      throwsNotice(NoticeFailureReason.senderNotMember),
    );
  });

  group('NoticeContent (A2)', () {
    test('custom text is trimmed and limited to 200 characters', () {
      expect(NoticeContent.custom('  hola ').text, 'hola');
      expect(NoticeContent.custom('x' * 200).text, hasLength(200));
      expect(
        () => NoticeContent.custom('x' * 201),
        throwsNotice(NoticeFailureReason.textTooLong),
      );
      expect(
        () => NoticeContent.custom('  '),
        throwsNotice(NoticeFailureReason.textRequired),
      );
    });

    test('compares by value', () {
      expect(NoticeContent.custom('a'), NoticeContent.custom('a'));
      expect(
        NoticeContent.custom('a').hashCode,
        NoticeContent.custom('a').hashCode,
      );
      expect(
        NoticeContent.fromTemplate(NoticeTemplate.askIfPaid),
        isNot(NoticeContent.custom('a')),
      );
    });

    test('failure describes itself', () {
      expect(
        const NoticeFailure(NoticeFailureReason.noRecipients).toString(),
        'NoticeFailure(noRecipients)',
      );
    });
  });

  test('skipped recipients compare by value', () {
    expect(SkippedRecipient('a', t0), SkippedRecipient('a', t0));
    expect(
      SkippedRecipient('a', t0).hashCode,
      SkippedRecipient('a', t0).hashCode,
    );
  });
}
