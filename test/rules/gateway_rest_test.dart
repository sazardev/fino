import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/sync/remote_change_kind.dart';
import 'package:fino/core/sync/remote_failure.dart';
import 'package:fino/core/sync/remote_failure_kind.dart';
import 'package:fino/core/sync/remote_filter.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/core/sync/rest/emulator_token.dart';
import 'package:fino/core/sync/rest/firestore_rest_gateway.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/firestore_rest.dart';
import 'support/rules_emulator.dart';
import 'support/rules_gateway.dart';
import 'support/rules_world.dart';

Matcher throwsRemote(RemoteFailureKind kind) =>
    throwsA(isA<RemoteFailure>().having((e) => e.kind, 'kind', kind));

void main() {
  if (skipWithoutRulesEmulator()) return;

  late RulesWorld w;
  setUp(() async => w = await RulesWorld.seed(FirestoreRest.fromEnvironment()));

  RemoteWrite order(String id, {String creditor = 'omar'}) => RemoteWrite(
    collection: w.path('orders'),
    id: id,
    operation: OutboxOperation.create,
    fields: {
      'creditorId': creditor,
      'concept': 'Café',
      'total': 30000,
      'spentAt': DateTime.utc(2026, 10, 6),
      'createdAt': RemoteMarker.serverTimestamp,
      'updatedAt': RemoteMarker.serverTimestamp,
    },
  );

  group('commit', () {
    test('writes a document the rules accept and get returns it', () async {
      await gatewayFor('omar').commit([order('o1')]);

      final doc = await gatewayFor('ana').get(w.path('orders/o1'));

      expect(doc!.fields['total'], 30000);
      expect(doc.fields['createdAt'], isA<DateTime>());
      expect(doc.fields['spentAt'], DateTime.utc(2026, 10, 6));
      expect(doc.id, 'o1');
    });

    test('is atomic: one rejected write leaves nothing behind', () async {
      final gateway = gatewayFor('omar');

      await expectLater(
        gateway.commit([order('o1'), order('o2', creditor: 'ana')]),
        throwsRemote(RemoteFailureKind.permissionDenied),
      );

      expect(await gateway.get(w.path('orders/o1')), isNull);
    });

    test('an empty batch does nothing', () async {
      await gatewayFor('omar').commit(const []);
    });

    test(
      'a rejected update (even of a missing document) is permission denied',
      () async {
        await expectLater(
          gatewayFor('omar').commit([
            RemoteWrite(
              collection: w.path('orders'),
              id: 'ghost',
              operation: OutboxOperation.update,
              fields: const {
                'concept': 'x',
                'updatedAt': RemoteMarker.serverTimestamp,
              },
            ),
          ]),
          throwsRemote(RemoteFailureKind.permissionDenied),
        );
        await expectLater(
          gatewayFor('zoe').commit([order('o9', creditor: 'zoe')]),
          throwsRemote(RemoteFailureKind.permissionDenied),
        );
      },
    );

    test('an unreachable server is a transient failure', () async {
      final offline = FirestoreRestGateway(
        host: 'localhost:1',
        project: 'demo-fino-rules',
        tokenProvider: () => emulatorTokenFor('omar'),
      );

      await expectLater(
        offline.commit([order('o1')]),
        throwsA(
          isA<RemoteFailure>().having(
            (e) => e.isTransient,
            'transient',
            isTrue,
          ),
        ),
      );
    });
  });

  group('get', () {
    test('a missing document is null; a forbidden one is denied', () async {
      expect(await gatewayFor('omar').get(w.path('orders/nope')), isNull);
      await expectLater(
        gatewayFor('zoe').get(w.path('orders/nope')),
        throwsRemote(RemoteFailureKind.permissionDenied),
      );
    });
  });

  group('watching', () {
    test('a collection emits its initial state, then changes', () async {
      await w.seedOrder('o1');
      final gateway = gatewayFor('ana');

      final events = gateway.watchCollection(w.path('orders')).take(3);
      final future = events.toList();
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await gatewayFor('omar').commit([order('o2')]);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await gatewayFor('omar').commit([
        RemoteWrite(
          collection: w.path('orders'),
          id: 'o2',
          operation: OutboxOperation.update,
          fields: const {
            'concept': 'Comida',
            'total': 30000,
            'spentAt': RemoteMarker.serverTimestamp,
            'updatedAt': RemoteMarker.serverTimestamp,
          },
        ),
      ]);

      final snapshots = await future.timeout(const Duration(seconds: 10));

      expect(snapshots[0].isInitial, isTrue);
      expect(snapshots[0].changes.single.document.id, 'o1');
      expect(snapshots[1].changes.single.kind, RemoteChangeKind.added);
      expect(snapshots[2].changes.single.kind, RemoteChangeKind.modified);
      expect(snapshots[2].changes.single.document.fields['concept'], 'Comida');
    });

    test('filters narrow a collection; a group finds my memberships', () async {
      final gateway = gatewayFor('ana');

      final mine = await gateway
          .watchGroup(
            'members',
            where: const [RemoteFilter.equal('userId', 'ana')],
          )
          .first;
      final onlyOpen = await gateway
          .watchCollection(
            w.path('ledger'),
            where: const [RemoteFilter.equal('confidential', false)],
          )
          .first;

      expect(
        mine.changes.map((c) => c.document.path),
        contains('teams/${w.teamId}/members/ana'),
      );
      expect(
        mine.changes.every((c) => c.document.fields['userId'] == 'ana'),
        isTrue,
      );
      expect(onlyOpen.changes, isEmpty);
    });

    test('a forbidden query fails with permission denied', () async {
      await expectLater(
        gatewayFor('zoe').watchCollection(w.path('orders')).first,
        throwsRemote(RemoteFailureKind.permissionDenied),
      );
    });

    test('a document emits null, then its value, then null again', () async {
      final gateway = gatewayFor('omar');

      final future = gateway
          .watchDocument(w.path('orders/o1'))
          .take(3)
          .toList();
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await gateway.commit([order('o1')]);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await w.owner([Write.remove(w.path('orders/o1'))]);

      final values = await future.timeout(const Duration(seconds: 10));

      expect(values[0], isNull);
      expect(values[1]!.fields['concept'], 'Café');
      expect(values[2], isNull);
    });
  });
}
