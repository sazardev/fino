import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/sync/remote_array_op.dart';
import 'package:fino/core/sync/remote_change_kind.dart';
import 'package:fino/core/sync/remote_document.dart';
import 'package:fino/core/sync/remote_failure_kind.dart';
import 'package:fino/core/sync/remote_filter.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/core/sync/rest/rest_failure_mapper.dart';
import 'package:fino/core/sync/rest/rest_query_builder.dart';
import 'package:fino/core/sync/rest/rest_value_codec.dart';
import 'package:fino/core/sync/rest/rest_write_encoder.dart';
import 'package:fino/core/sync/rest/snapshot_differ.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RestValueCodec', () {
    test('every supported value survives encode → decode', () {
      final fields = <String, Object?>{
        'text': 'hola',
        'int': 6000,
        'double': 1.5,
        'yes': true,
        'nothing': null,
        'when': DateTime.utc(2026, 10, 6, 12),
        'list': ['a', 1],
        'map': {
          'last4': '5671',
          'nested': {'x': 1},
        },
      };

      final decoded = RestValueCodec.decodeFields(
        RestValueCodec.encodeFields(fields),
      );

      expect(decoded, fields);
    });

    test('empty arrays and maps decode to empty collections', () {
      expect(
        RestValueCodec.decode({'arrayValue': <String, Object?>{}}),
        isEmpty,
      );
      expect(RestValueCodec.decode({'mapValue': <String, Object?>{}}), isEmpty);
    });

    test('rejects what Firestore cannot store', () {
      expect(() => RestValueCodec.encode(Object()), throwsArgumentError);
    });
  });

  group('RestWriteEncoder', () {
    const docs = 'projects/p/databases/(default)/documents';

    test('create has no precondition; markers become transforms', () {
      final json = RestWriteEncoder.encode(
        const RemoteWrite(
          collection: 'teams/t1/orders',
          id: 'o1',
          operation: OutboxOperation.create,
          fields: {
            'total': 100,
            'createdAt': RemoteMarker.serverTimestamp,
            'memberIds': RemoteArrayOp.union(['a']),
          },
        ),
        docs,
      );

      expect((json['update']! as Map)['name'], '$docs/teams/t1/orders/o1');
      expect(json, isNot(contains('currentDocument')));
      expect(json['updateTransforms'], [
        {'fieldPath': 'createdAt', 'setToServerValue': 'REQUEST_TIME'},
        {
          'fieldPath': 'memberIds',
          'appendMissingElements': {
            'values': [
              {'stringValue': 'a'},
            ],
          },
        },
      ]);
    });

    test('update masks its fields, requires existence and deletes fields', () {
      final json = RestWriteEncoder.encode(
        const RemoteWrite(
          collection: 'teams/t1/debts',
          id: 'd1',
          operation: OutboxOperation.update,
          fields: {
            'status': 'pending',
            'paymentId': RemoteMarker.fieldDelete,
            'gone': RemoteArrayOp.remove(['x']),
          },
        ),
        docs,
      );

      expect(json['currentDocument'], {'exists': true});
      expect((json['updateMask']! as Map)['fieldPaths'], [
        'status',
        'paymentId',
      ]);
      expect(
        (json['updateTransforms']! as List).single,
        containsPair('removeAllFromArray', isNotNull),
      );
    });

    test('set replaces; delete only names the document', () {
      final set = RestWriteEncoder.encode(
        const RemoteWrite(
          collection: 'c',
          id: 'a',
          operation: OutboxOperation.set,
        ),
        docs,
      );
      final delete = RestWriteEncoder.encode(
        const RemoteWrite(
          collection: 'c',
          id: 'a',
          operation: OutboxOperation.delete,
        ),
        docs,
      );

      expect(set, isNot(contains('updateMask')));
      expect(set, isNot(contains('currentDocument')));
      expect(delete, {'delete': '$docs/c/a'});
    });
  });

  group('RestQueryBuilder', () {
    test('no filter, one filter and several filters', () {
      Map<String, Object?> query(List<RemoteFilter> where) =>
          RestQueryBuilder.query(
                collectionId: 'ledger',
                allDescendants: false,
                where: where,
              )['structuredQuery']!
              as Map<String, Object?>;

      expect(query(const []), isNot(contains('where')));
      final one = query([const RemoteFilter.equal('userId', 'u1')]);
      expect(((one['where']! as Map)['fieldFilter']! as Map)['op'], 'EQUAL');
      final many = query([
        const RemoteFilter.equal('confidential', false),
        const RemoteFilter.arrayContains('partyIds', 'u1'),
      ]);
      final composite = (many['where']! as Map)['compositeFilter']! as Map;
      expect(composite['op'], 'AND');
      expect(composite['filters'], hasLength(2));
    });
  });

  group('RestFailureMapper', () {
    test('HTTP statuses become failure kinds', () {
      RemoteFailureKind kind(int status) =>
          RestFailureMapper.fromResponse(status, '{}').kind;

      expect(kind(401), RemoteFailureKind.unauthenticated);
      expect(kind(403), RemoteFailureKind.permissionDenied);
      expect(kind(404), RemoteFailureKind.notFound);
      expect(kind(409), RemoteFailureKind.alreadyExists);
      expect(kind(503), RemoteFailureKind.unavailable);
      expect(kind(500), RemoteFailureKind.other);
    });

    test('the server message is kept, including in query errors', () {
      expect(
        RestFailureMapper.fromResponse(
          403,
          '{"error":{"message":"denied by rule"}}',
        ).message,
        'denied by rule',
      );
      expect(
        RestFailureMapper.fromResponse(
          403,
          '[{"error":{"message":"in a list"}}]',
        ).message,
        'in a list',
      );
      expect(
        RestFailureMapper.fromResponse(500, 'not json').message,
        'not json',
      );
    });

    test('transient failures are worth retrying, rule rejections are not', () {
      expect(RestFailureMapper.fromResponse(503, '').isTransient, isTrue);
      expect(RestFailureMapper.fromResponse(403, '').isTransient, isFalse);
      expect(
        RestFailureMapper.fromError(StateError('boom')).kind,
        RemoteFailureKind.other,
      );
    });
  });

  group('SnapshotDiffer', () {
    RemoteDocument doc(String id, [int n = 0]) =>
        RemoteDocument('c/$id', {'n': n});

    test('the first call reports everything as initial', () {
      final snapshot = SnapshotDiffer().next([doc('a'), doc('b')])!;

      expect(snapshot.isInitial, isTrue);
      expect(snapshot.changes, hasLength(2));
    });

    test('later calls report added, modified and removed only', () {
      final differ = SnapshotDiffer()..next([doc('a'), doc('b')]);

      final snapshot = differ.next([doc('a', 1), doc('c')])!;

      expect(snapshot.isInitial, isFalse);
      expect(
        {for (final c in snapshot.changes) c.document.id: c.kind},
        {
          'a': RemoteChangeKind.modified,
          'c': RemoteChangeKind.added,
          'b': RemoteChangeKind.removed,
        },
      );
      expect(differ.next([doc('a', 1), doc('c')]), isNull);
    });

    test('an empty first poll still reports the (empty) initial state', () {
      final snapshot = SnapshotDiffer().next(const [])!;

      expect(snapshot.isInitial, isTrue);
      expect(snapshot.changes, isEmpty);
    });
  });

  test('documents expose their id and collection and compare deeply', () {
    const a = RemoteDocument('teams/t1/debts/d1', {
      'tags': ['x'],
      'm': {'k': 1},
    });

    expect(a.id, 'd1');
    expect(a.collection, 'teams/t1/debts');
    expect(
      a,
      const RemoteDocument('teams/t1/debts/d1', {
        'tags': ['x'],
        'm': {'k': 1},
      }),
    );
    expect(
      a ==
          const RemoteDocument('teams/t1/debts/d1', {
            'tags': ['y'],
            'm': {'k': 1},
          }),
      isFalse,
    );
    expect(a.toString(), contains('d1'));
  });
}
