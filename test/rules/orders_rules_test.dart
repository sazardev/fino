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

  group('creating an order (SPEC 5)', () {
    test('the creditor writes the order and its debts together', () async {
      expect(
        await w.as('omar', [
          Write.create(w.path('orders/o1'), w.orderData()),
          Write.create(w.path('debts/d1'), w.debtData('o1', 'ana')),
          Write.create(w.path('debts/d2'), w.debtData('o1', 'beto')),
        ]),
        isAllowed,
      );
    });

    test('a big order stays under the 20 access-call batch limit', () async {
      final members = [for (var i = 0; i < 12; i++) 'u$i'];
      await w.owner([
        Write.update('teams/${w.teamId}', {'memberIds': ArrayUnion(members)}),
      ]);

      expect(
        await w.as('omar', [
          Write.create(w.path('orders/o1'), w.orderData()),
          for (final (i, uid) in members.indexed) ...[
            Write.create(w.path('debts/d$i'), w.debtData('o1', uid)),
            Write.create(w.path('ledger/l$i'), w.ledgerData('omar')),
            Write.create('users/$uid/inbox/n$i-${w.id}', w.inboxData('omar')),
          ],
        ]),
        isAllowed,
      );
    });

    test('needs a payout method (M2)', () async {
      expect(
        await w.as('ana', [
          Write.create(w.path('orders/o1'), w.orderData(creditor: 'ana')),
        ]),
        isDenied,
      );
    });

    test('outsiders cannot create orders', () async {
      expect(
        await w.as('zoe', [
          Write.create(w.path('orders/o1'), w.orderData(creditor: 'zoe')),
        ]),
        isDenied,
      );
    });

    test('cannot create an order in someone else name', () async {
      expect(
        await w.as('ana', [Write.create(w.path('orders/o1'), w.orderData())]),
        isDenied,
      );
    });

    test('rejects a non-positive total or an empty concept', () async {
      expect(
        await w.as('omar', [
          Write.create(w.path('orders/o1'), w.orderData(total: 0)),
        ]),
        isDenied,
      );
      expect(
        await w.as('omar', [
          Write.create(w.path('orders/o2'), {...w.orderData(), 'concept': ''}),
        ]),
        isDenied,
      );
    });

    test(
      'a debt needs its order, a member debtor and the creditor as author',
      () async {
        expect(
          await w.as('omar', [
            Write.create(w.path('debts/d1'), w.debtData('o9', 'ana')),
          ]),
          isDenied,
        );
        expect(
          await w.as('omar', [
            Write.create(w.path('orders/o1'), w.orderData()),
            Write.create(w.path('debts/d1'), w.debtData('o1', 'zoe')),
          ]),
          isDenied,
        );
        expect(
          await w.as('omar', [
            Write.create(w.path('orders/o1'), w.orderData()),
            Write.create(w.path('debts/d1'), w.debtData('o1', 'omar')),
          ]),
          isDenied,
        );
        await w.seedOrder('o2');
        expect(
          await w.as('ana', [
            Write.create(w.path('debts/d1'), {
              ...w.debtData('o2', 'beto'),
              'creditorId': 'ana',
            }),
          ]),
          isDenied,
        );
      },
    );

    test(
      'debts are born pending, with a positive amount and no payment',
      () async {
        await w.seedOrder('o1');
        for (final bad in [
          {...w.debtData('o1', 'ana'), 'status': 'confirmed'},
          {...w.debtData('o1', 'ana'), 'amount': 0},
          {...w.debtData('o1', 'ana'), 'paymentId': 'p1'},
        ]) {
          expect(
            await w.as('omar', [Write.create(w.path('debts/dx'), bad)]),
            isDenied,
          );
        }
      },
    );

    test('debtors can be added later to an existing order', () async {
      await w.seedOrder('o1');

      expect(
        await w.as('omar', [
          Write.create(w.path('debts/d3'), w.debtData('o1', 'beto')),
        ]),
        isAllowed,
      );
    });
  });

  group('editing and visibility', () {
    setUp(() => w.seedOrder('o1'));

    test('the creditor edits the order but not its identity', () async {
      expect(
        await w.as('omar', [
          Write.update(w.path('orders/o1'), {
            'concept': 'Comida',
            'total': 40000,
            'updatedAt': const ServerTime(),
          }),
        ]),
        isAllowed,
      );
      expect(
        await w.as('omar', [
          Write.update(w.path('orders/o1'), {
            'creditorId': 'ana',
            'updatedAt': const ServerTime(),
          }),
        ]),
        isDenied,
      );
    });

    test('nobody else edits it and nobody deletes it', () async {
      expect(
        await w.as('ana', [
          Write.update(w.path('orders/o1'), {
            'concept': 'Hack',
            'updatedAt': const ServerTime(),
          }),
        ]),
        isDenied,
      );
      expect(await w.as('omar', [Write.remove(w.path('orders/o1'))]), isDenied);
    });

    test(
      'every member reads orders and debts; outsiders read nothing (7.1)',
      () async {
        await w.seedDebt('d1');

        expect(await w.read('beto', w.path('orders/o1')), isAllowed);
        expect(await w.read('beto', w.path('debts/d1')), isAllowed);
        expect(await w.read('zoe', w.path('orders/o1')), isDenied);
        expect(await w.read('zoe', w.path('debts/d1')), isDenied);
      },
    );
  });
}
