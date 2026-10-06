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

  String payout(String uid) => w.path('members/$uid/payout/main');
  String payer(String owner, String debtor) =>
      w.path('members/$owner/payers/$debtor');

  group('payout method (M1, M4)', () {
    test('its owner writes and reads it', () async {
      expect(
        await w.as('ana', [
          Write.create(payout('ana'), {
            'type': 'card',
            'number': '4152313312345678',
            'bankName': 'BBVA',
          }),
        ]),
        isAllowed,
      );
      expect(await w.read('ana', payout('ana')), isAllowed);
    });

    test('nobody else writes it', () async {
      expect(
        await w.as('ana', [
          Write.update(payout('omar'), {'number': '012180000112345671'}),
        ]),
        isDenied,
      );
    });

    test('a teammate without a live debt cannot read it', () async {
      expect(await w.read('ana', payout('omar')), isDenied);
    });

    test('the debtor the owner registered can read it', () async {
      await w.as('omar', [Write.create(payer('omar', 'ana'), {})]);

      expect(await w.read('ana', payout('omar')), isAllowed);
      expect(await w.read('beto', payout('omar')), isDenied);
    });

    test('once the owner removes the marker the access is gone', () async {
      await w.as('omar', [Write.create(payer('omar', 'ana'), {})]);
      await w.as('omar', [Write.remove(payer('omar', 'ana'))]);

      expect(await w.read('ana', payout('omar')), isDenied);
    });

    test('only the owner manages who can see it', () async {
      expect(
        await w.as('ana', [Write.create(payer('omar', 'ana'), {})]),
        isDenied,
      );
      expect(
        await w.as('omar', [Write.create(payer('omar', 'zoe'), {})]),
        isDenied,
      );
    });

    test('rejects malformed CLABE, card or missing bank', () async {
      Future<RestResult> save(Map<String, Object?> data) =>
          w.as('ana', [Write.create(payout('ana'), data)]);

      expect(await save({'type': 'clabe', 'number': '123'}), isDenied);
      expect(
        await save({'type': 'card', 'number': '4152313312345678'}),
        isDenied,
      );
      expect(
        await save({'type': 'card', 'number': '123', 'bankName': 'BBVA'}),
        isDenied,
      );
      expect(
        await save({'type': 'crypto', 'number': '012180000112345671'}),
        isDenied,
      );
    });

    test('can be replaced but never removed', () async {
      expect(
        await w.as('omar', [
          Write.update(payout('omar'), {
            'type': 'clabe',
            'number': '012180000112345671',
            'holderName': 'Omar',
          }),
        ]),
        isAllowed,
      );
      expect(await w.as('omar', [Write.remove(payout('omar'))]), isDenied);
    });
  });
}
