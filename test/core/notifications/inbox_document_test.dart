import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/inbox_document.dart';
import 'package:fino/core/notifications/inbox_write_planner.dart';
import 'package:fino/core/notifications/intent/notification_intent.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const full = NotificationIntent(
    kind: NotificationKind.paymentReviewed,
    recipientId: 'ana',
    actorId: 'omar',
    teamId: 't1',
    target: NotificationTarget.payment('p1'),
    amount: Money(18000),
    concept: 'Café',
    debtCount: 2,
    rejectedCount: 1,
    note: 'no llegó',
    templateKey: 'askIfPaid',
  );
  const bare = NotificationIntent(
    kind: NotificationKind.memberJoined,
    recipientId: 'omar',
    actorId: 'zoe',
    teamId: 't1',
    target: NotificationTarget.team('t1'),
  );

  test('an intent round-trips through its inbox document', () {
    for (final intent in [full, bare]) {
      final fields = InboxDocument.toFields(intent);

      expect(fields['createdAt'], RemoteMarker.serverTimestamp);
      expect(
        InboxDocument.fromFields(fields, recipientId: intent.recipientId),
        intent,
      );
    }
  });

  test('absent optional data is omitted from the document', () {
    final fields = InboxDocument.toFields(bare);

    expect(fields.keys, containsAll(['kind', 'actorId', 'teamId']));
    expect(fields, isNot(contains('amountCents')));
    expect(fields, isNot(contains('note')));
  });

  test('each notification becomes a create in its recipient inbox', () {
    var n = 0;
    final writes = InboxWritePlanner(() => 'n${++n}').plan([full, bare]);

    expect(writes.map((w) => w.path), [
      'users/ana/inbox/n1',
      'users/omar/inbox/n2',
    ]);
    expect(
      writes.map((w) => w.operation),
      everyElement(OutboxOperation.create),
    );
  });
}
