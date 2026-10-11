import 'package:fino/core/sync/initial_snapshot_tracker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('only the first server snapshot is initial', () {
    final tracker = InitialSnapshotTracker();

    expect(tracker.next(isFromCache: false), isTrue);
    expect(tracker.next(isFromCache: false), isFalse);
    expect(tracker.next(isFromCache: true), isFalse);
    expect(tracker.next(isFromCache: false), isFalse);
  });

  test('a cache snapshot first never counts as initial', () {
    final tracker = InitialSnapshotTracker();

    // El SDK entrega una instantánea de caché como única de la consulta
    // (el documento ya estaba en su caché por otro listener): no debe purgar.
    expect(tracker.next(isFromCache: true), isFalse);
    // Si el servidor llega después, esa sí es la inicial.
    expect(tracker.next(isFromCache: false), isTrue);
    expect(tracker.next(isFromCache: false), isFalse);
  });
}
