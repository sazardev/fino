import 'package:fino/core/database/outbox_backoff.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('doubles from 5 seconds', () {
    expect(outboxBackoff(1), const Duration(seconds: 5));
    expect(outboxBackoff(2), const Duration(seconds: 10));
    expect(outboxBackoff(3), const Duration(seconds: 20));
  });

  test('never exceeds one hour, even after many attempts', () {
    expect(outboxBackoff(30), const Duration(hours: 1));
    expect(outboxBackoff(1000), const Duration(hours: 1));
  });

  test('treats zero attempts like the first', () {
    expect(outboxBackoff(0), const Duration(seconds: 5));
  });
}
