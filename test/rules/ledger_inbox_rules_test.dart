import 'package:flutter_test/flutter_test.dart';

import 'support/firestore_rest.dart';
import 'support/rules_emulator.dart';
import 'support/rules_matchers.dart';
import 'support/rules_world.dart';

void main() {
  if (skipWithoutRulesEmulator()) return;

  late FirestoreRest db;
  late RulesWorld w;

  setUpAll(() => db = FirestoreRest.fromEnvironment());
  setUp(() async => w = await RulesWorld.seed(db));

  group('ledger (SPEC 11)', () {
    test('a member records an event as themselves', () async {
      expect(
        await w.as('ana', [
          Write.create(w.path('ledger/l1'), w.ledgerData('ana')),
        ]),
        isAllowed,
      );
    });

    test(
      'cannot record an event in someone else name or as an outsider',
      () async {
        expect(
          await w.as('ana', [
            Write.create(w.path('ledger/l1'), w.ledgerData('omar')),
          ]),
          isDenied,
        );
        expect(
          await w.as('zoe', [
            Write.create(w.path('ledger/l1'), w.ledgerData('zoe')),
          ]),
          isDenied,
        );
      },
    );

    test('confidential flag must match the event type', () async {
      expect(
        await w.as('ana', [
          Write.create(
            w.path('ledger/l1'),
            w.ledgerData('ana', type: 'paymentReported', confidential: false),
          ),
        ]),
        isDenied,
      );
      expect(
        await w.as('ana', [
          Write.create(
            w.path('ledger/l2'),
            w.ledgerData('ana', type: 'madeUp'),
          ),
        ]),
        isDenied,
      );
    });

    test('it is immutable', () async {
      await w.as('ana', [
        Write.create(w.path('ledger/l1'), w.ledgerData('ana')),
      ]);

      expect(
        await w.as('ana', [
          Write.update(w.path('ledger/l1'), {'note': 'x'}),
        ]),
        isDenied,
      );
      expect(await w.as('ana', [Write.remove(w.path('ledger/l1'))]), isDenied);
    });

    test(
      'everyone reads ordinary entries; only parties read the rest',
      () async {
        await w.owner([
          Write.create(w.path('ledger/open'), {
            ...w.ledgerData('ana'),
            'at': seededAt,
          }),
          Write.create(w.path('ledger/secret'), {
            ...w.ledgerData('ana', type: 'paymentReported'),
            'at': seededAt,
          }),
        ]);

        expect(await w.read('beto', w.path('ledger/open')), isAllowed);
        expect(await w.read('ana', w.path('ledger/secret')), isAllowed);
        expect(await w.read('omar', w.path('ledger/secret')), isAllowed);
        expect(await w.read('beto', w.path('ledger/secret')), isDenied);
        expect(await w.read('zoe', w.path('ledger/open')), isDenied);
      },
    );
  });

  group('payments', () {
    test('only the creditor flags the 48h reminder, once', () async {
      await w.seedPayment('p1', ['d1']);
      Write flag() => Write.update(w.path('payments/p1'), {
        'awaitingConfirmationReminderSent': true,
      });

      expect(await w.as('ana', [flag()]), isDenied);
      expect(await w.as('omar', [flag()]), isAllowed);
    });

    test('a payment is never deleted or rewritten', () async {
      await w.seedPayment('p1', ['d1']);

      expect(
        await w.as('ana', [Write.remove(w.path('payments/p1'))]),
        isDenied,
      );
      expect(
        await w.as('ana', [
          Write.update(w.path('payments/p1'), {
            'debtIds': ['x'],
          }),
        ]),
        isDenied,
      );
    });

    test('a payment is addressed to a member creditor', () async {
      expect(
        await w.as('ana', [
          Write.create(w.path('payments/p2'), {
            ...w.paymentData('ana', ['d1']),
            'creditorId': 'zoe',
          }),
        ]),
        isDenied,
      );
    });
  });

  group('notices (A5)', () {
    Map<String, Object?> notice(List<String> to) => {
      'senderId': 'omar',
      'recipientIds': to,
      'text': 'ya paguen',
      'sentAt': const ServerTime(),
    };

    test('the sender logs it and only the sender reads it', () async {
      expect(
        await w.as('omar', [
          Write.create(w.path('notices/n1'), notice(['ana', 'beto'])),
        ]),
        isAllowed,
      );
      expect(await w.read('omar', w.path('notices/n1')), isAllowed);
      expect(await w.read('ana', w.path('notices/n1')), isDenied);
    });

    test('recipients must be team members, never the sender', () async {
      expect(
        await w.as('omar', [
          Write.create(w.path('notices/n1'), notice(['zoe'])),
        ]),
        isDenied,
      );
      expect(
        await w.as('omar', [
          Write.create(w.path('notices/n2'), notice(['omar'])),
        ]),
        isDenied,
      );
      expect(
        await w.as('ana', [
          Write.create(w.path('notices/n3'), notice(['beto'])),
        ]),
        isDenied,
      );
    });
  });

  group('inbox', () {
    String inbox(String uid, [String id = 'n1']) =>
        'users/$uid/inbox/$id${w.id}';

    test('a teammate leaves a notification for another member', () async {
      expect(
        await w.as('omar', [Write.create(inbox('ana'), w.inboxData('omar'))]),
        isAllowed,
      );
    });

    test('it cannot be forged, sent to outsiders or from outsiders', () async {
      expect(
        await w.as('omar', [Write.create(inbox('ana'), w.inboxData('beto'))]),
        isDenied,
      );
      expect(
        await w.as('omar', [Write.create(inbox('zoe'), w.inboxData('omar'))]),
        isDenied,
      );
      expect(
        await w.as('zoe', [Write.create(inbox('ana'), w.inboxData('zoe'))]),
        isDenied,
      );
    });

    test('rejects unknown kinds and extra fields', () async {
      expect(
        await w.as('omar', [
          Write.create(inbox('ana'), w.inboxData('omar', kind: 'spam')),
        ]),
        isDenied,
      );
      expect(
        await w.as('omar', [
          Write.create(inbox('ana'), {...w.inboxData('omar'), 'evil': true}),
        ]),
        isDenied,
      );
    });

    test('only its owner reads, marks it read and clears it', () async {
      await w.as('omar', [Write.create(inbox('ana'), w.inboxData('omar'))]);

      expect(await w.read('ana', inbox('ana')), isAllowed);
      expect(await w.read('omar', inbox('ana')), isDenied);
      expect(
        await w.as('ana', [
          Write.update(inbox('ana'), {'readAt': seededAt}),
        ]),
        isAllowed,
      );
      expect(
        await w.as('ana', [
          Write.update(inbox('ana'), {'note': 'x'}),
        ]),
        isAllowed, // el dueño de /users/{uid}/** edita lo suyo
      );
      expect(
        await w.as('omar', [
          Write.update(inbox('ana'), {'readAt': seededAt}),
        ]),
        isDenied,
      );
      expect(await w.as('ana', [Write.remove(inbox('ana'))]), isAllowed);
    });
  });
}
