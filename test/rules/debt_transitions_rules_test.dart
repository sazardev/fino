import 'package:flutter_test/flutter_test.dart';

import 'support/firestore_rest.dart';
import 'support/rules_emulator.dart';
import 'support/rules_matchers.dart';
import 'support/rules_world.dart';

/// La máquina de estados de la deuda (SPEC 6.1) hecha reglas.
void main() {
  if (skipWithoutRulesEmulator()) return;

  late FirestoreRest db;
  late RulesWorld w;

  setUpAll(() => db = FirestoreRest.fromEnvironment());
  setUp(() async {
    w = await RulesWorld.seed(db);
    await w.seedOrder('o1');
  });

  Write move(
    String status, {
    String? paymentId,
    int? amount,
    bool dropPayment = false,
  }) => Write.update(
    w.path('debts/d1'),
    {
      'status': status,
      'paymentId': ?paymentId,
      'amount': ?amount,
      'updatedAt': const ServerTime(),
    },
    deleteFields: [if (dropPayment) 'paymentId'],
  );

  Future<RestResult> report(String uid, {String debtor = 'ana'}) => w.as(uid, [
    Write.create(w.path('payments/p9'), w.paymentData(debtor, ['d1'])),
    move('paymentReported', paymentId: 'p9'),
  ]);

  group('the debtor', () {
    setUp(() => w.seedDebt('d1'));

    test('reports a payment together with its payment doc', () async {
      expect(await report('ana'), isAllowed);
    });

    test('cannot report without the payment doc', () async {
      expect(
        await w.as('ana', [move('paymentReported', paymentId: 'p9')]),
        isDenied,
      );
    });

    test('cannot report a payment that omits the debt', () async {
      expect(
        await w.as('ana', [
          Write.create(w.path('payments/p9'), w.paymentData('ana', ['other'])),
          move('paymentReported', paymentId: 'p9'),
        ]),
        isDenied,
      );
    });

    test('cannot report on behalf of another debtor', () async {
      expect(await report('beto', debtor: 'beto'), isDenied);
    });

    test('cannot confirm, cancel or edit the amount', () async {
      expect(await w.as('ana', [move('confirmed')]), isDenied);
      expect(await w.as('ana', [move('cancelled')]), isDenied);
      expect(await w.as('ana', [move('pending', amount: 100)]), isDenied);
    });

    test('retracts the report: back to pending without payment', () async {
      await w.seedDebt('d2', status: 'paymentReported', paymentId: 'p1');
      await w.seedPayment('p1', ['d2']);

      expect(
        await w.as('ana', [
          Write.update(
            w.path('debts/d2'),
            {'status': 'pending', 'updatedAt': const ServerTime()},
            deleteFields: ['paymentId'],
          ),
        ]),
        isAllowed,
      );
    });
  });

  group('the creditor', () {
    test('edits the amount of a pending debt', () async {
      await w.seedDebt('d1');

      expect(await w.as('omar', [move('pending', amount: 4000)]), isAllowed);
      expect(await w.as('omar', [move('pending', amount: 0)]), isDenied);
    });

    test('cancels a pending debt', () async {
      await w.seedDebt('d1');

      expect(await w.as('omar', [move('cancelled')]), isAllowed);
    });

    test('cannot cancel a debt with a reported payment (D2)', () async {
      await w.seedDebt('d1', status: 'paymentReported', paymentId: 'p1');

      expect(await w.as('omar', [move('cancelled')]), isDenied);
    });

    test('cannot confirm or reject what was never reported', () async {
      await w.seedDebt('d1');

      expect(await w.as('omar', [move('confirmed')]), isDenied);
    });

    group('with a reported payment', () {
      setUp(() => w.seedDebt('d1', status: 'paymentReported', paymentId: 'p1'));

      test('confirms it', () async {
        expect(
          await w.as('omar', [move('confirmed', paymentId: 'p1')]),
          isAllowed,
        );
      });

      test('cannot confirm while changing the amount or the payment', () async {
        expect(
          await w.as('omar', [move('confirmed', paymentId: 'p1', amount: 1)]),
          isDenied,
        );
        expect(
          await w.as('omar', [move('confirmed', paymentId: 'other')]),
          isDenied,
        );
      });

      test('rejects it: back to pending without payment', () async {
        expect(
          await w.as('omar', [move('pending', dropPayment: true)]),
          isAllowed,
        );
        expect(
          await w.as('omar', [move('pending', paymentId: 'p1')]),
          isDenied,
        );
      });
    });

    group('with a confirmed debt', () {
      setUp(() => w.seedDebt('d1', status: 'confirmed', paymentId: 'p1'));

      test('undoes the confirmation (D4)', () async {
        expect(
          await w.as('omar', [move('paymentReported', paymentId: 'p1')]),
          isAllowed,
        );
      });

      test('cannot undo once the debtor left the team', () async {
        await w.owner([
          Write.update('teams/${w.teamId}', {
            'memberIds': const ArrayRemove(['ana']),
          }),
        ]);

        expect(
          await w.as('omar', [move('paymentReported', paymentId: 'p1')]),
          isDenied,
        );
      });

      test('cannot be cancelled', () async {
        expect(await w.as('omar', [move('cancelled')]), isDenied);
      });
    });

    test('a cancelled debt is final', () async {
      await w.seedDebt('d1', status: 'cancelled');

      for (final status in ['pending', 'confirmed', 'paymentReported']) {
        expect(await w.as('omar', [move(status)]), isDenied);
      }
    });
  });

  group('everyone', () {
    setUp(() => w.seedDebt('d1'));

    test('other members and outsiders cannot move a debt', () async {
      expect(await w.as('beto', [move('cancelled')]), isDenied);
      expect(await w.as('zoe', [move('cancelled')]), isDenied);
    });

    test('identity fields are immutable', () async {
      for (final field in ['debtorId', 'creditorId', 'orderId']) {
        expect(
          await w.as('omar', [
            Write.update(w.path('debts/d1'), {
              field: 'beto',
              'updatedAt': const ServerTime(),
            }),
          ]),
          isDenied,
        );
      }
    });

    test('debts are never deleted', () async {
      expect(await w.as('omar', [Write.remove(w.path('debts/d1'))]), isDenied);
    });
  });
}
