import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fino/core/sync/remote_array_op.dart';
import 'package:fino/core/sync/remote_failure_kind.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/core/sync/sdk/firestore_failure_mapper.dart';
import 'package:fino/core/sync/sdk/firestore_value_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirestoreValueCodec.encode', () {
    test('dates become timestamps, markers become field values', () {
      final at = DateTime.utc(2026, 10, 6, 12);

      final fields = FirestoreValueCodec.encodeFields({
        'spentAt': at,
        'createdAt': RemoteMarker.serverTimestamp,
        'paymentId': RemoteMarker.fieldDelete,
        'memberIds': const RemoteArrayOp.union(['a']),
        'gone': const RemoteArrayOp.remove(['b']),
        'total': 100,
        'nested': {'when': at},
        'list': [at],
      });

      expect(fields['spentAt'], Timestamp.fromDate(at));
      expect(fields['createdAt'], isA<FieldValue>());
      expect(fields['paymentId'], isA<FieldValue>());
      expect(fields['memberIds'], isA<FieldValue>());
      expect(fields['gone'], isA<FieldValue>());
      expect(fields['total'], 100);
      expect((fields['nested']! as Map)['when'], Timestamp.fromDate(at));
      expect((fields['list']! as List).single, Timestamp.fromDate(at));
    });
  });

  group('FirestoreValueCodec.decode', () {
    test('timestamps become UTC dates, everything else is kept', () {
      final at = DateTime.utc(2026, 10, 6, 12);

      final fields = FirestoreValueCodec.decodeFields({
        'at': Timestamp.fromDate(at),
        'n': 5,
        'text': 'hola',
        'nothing': null,
        'nested': {'when': Timestamp.fromDate(at)},
        'list': [Timestamp.fromDate(at), 'x'],
      });

      expect(fields['at'], at);
      expect((fields['at']! as DateTime).isUtc, isTrue);
      expect(fields['n'], 5);
      expect(fields['nothing'], isNull);
      expect(fields['nested'], {'when': at});
      expect(fields['list'], [at, 'x']);
    });

    test('a missing document has no fields', () {
      expect(FirestoreValueCodec.decodeFields(null), isEmpty);
    });
  });

  group('FirestoreFailureMapper', () {
    RemoteFailureKind kind(String code) => FirestoreFailureMapper.map(
      FirebaseException(plugin: 'cloud_firestore', code: code),
    ).kind;

    test('Firestore error codes become failure kinds', () {
      expect(kind('permission-denied'), RemoteFailureKind.permissionDenied);
      expect(kind('not-found'), RemoteFailureKind.notFound);
      expect(kind('already-exists'), RemoteFailureKind.alreadyExists);
      expect(kind('unauthenticated'), RemoteFailureKind.unauthenticated);
      for (final code in [
        'unavailable',
        'deadline-exceeded',
        'aborted',
        'resource-exhausted',
        'cancelled',
      ]) {
        expect(kind(code), RemoteFailureKind.unavailable);
      }
      expect(kind('invalid-argument'), RemoteFailureKind.other);
    });

    test('other errors are classified as other and keep their text', () {
      final failure = FirestoreFailureMapper.map(StateError('boom'));

      expect(failure.kind, RemoteFailureKind.other);
      expect(failure.message, contains('boom'));
      expect(FirestoreFailureMapper.map(failure), same(failure));
    });
  });
}
