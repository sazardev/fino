import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/sync/remote_array_op.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/core/sync/remote_write_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('everything an outbox payload carries survives JSON', () {
    final fields = <String, Object?>{
      'name': 'Café',
      'amount': 6000,
      'ratio': 0.5,
      'flag': true,
      'nothing': null,
      'spentAt': DateTime.utc(2026, 10, 6, 12),
      'createdAt': RemoteMarker.serverTimestamp,
      'paymentId': RemoteMarker.fieldDelete,
      'memberIds': const RemoteArrayOp.union(['a', 'b']),
      'gone': const RemoteArrayOp.remove(['c']),
      'payoutShown': {'last4': '5671', 'when': DateTime.utc(2026)},
      'debtIds': ['d1', 'd2'],
    };

    final decoded = RemoteWriteCodec.decode(RemoteWriteCodec.encode(fields));

    expect(decoded['name'], 'Café');
    expect(decoded['amount'], 6000);
    expect(decoded['ratio'], 0.5);
    expect(decoded['flag'], isTrue);
    expect(decoded['nothing'], isNull);
    expect(decoded['spentAt'], DateTime.utc(2026, 10, 6, 12));
    expect(decoded['createdAt'], RemoteMarker.serverTimestamp);
    expect(decoded['paymentId'], RemoteMarker.fieldDelete);
    final union = decoded['memberIds']! as RemoteArrayOp;
    expect(union.union, isTrue);
    expect(union.values, ['a', 'b']);
    final remove = decoded['gone']! as RemoteArrayOp;
    expect(remove.union, isFalse);
    expect(remove.values, ['c']);
    expect(decoded['payoutShown'], {
      'last4': '5671',
      'when': DateTime.utc(2026),
    });
    expect(decoded['debtIds'], ['d1', 'd2']);
  });

  test('an empty payload decodes to no fields (deletes, markers)', () {
    expect(RemoteWriteCodec.decode(''), isEmpty);
  });

  test('an outbox entry rebuilds its write', () {
    final write = RemoteWriteCodec.toWrite(
      entity: 'teams/t1/debts',
      entityId: 'd1',
      operation: OutboxOperation.update,
      payload: RemoteWriteCodec.encode({'status': 'confirmed'}),
    );

    expect(write.path, 'teams/t1/debts/d1');
    expect(write.operation, OutboxOperation.update);
    expect(write.fields, {'status': 'confirmed'});
  });

  test('a write exposes its document path', () {
    const write = RemoteWrite(
      collection: 'users/u1/inbox',
      id: 'n1',
      operation: OutboxOperation.create,
    );

    expect(write.path, 'users/u1/inbox/n1');
    expect(write.fields, isEmpty);
  });
}
