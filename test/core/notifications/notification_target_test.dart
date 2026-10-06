import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/core/notifications/intent/notification_target_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('named constructors pick the target type', () {
    expect(
      const NotificationTarget.debt('d1').type,
      NotificationTargetType.debt,
    );
    expect(
      const NotificationTarget.payment('p1').type,
      NotificationTargetType.payment,
    );
    expect(const NotificationTarget.pay('u1').type, NotificationTargetType.pay);
    expect(
      const NotificationTarget.history('t1').type,
      NotificationTargetType.history,
    );
    expect(
      const NotificationTarget.team('t1').type,
      NotificationTargetType.team,
    );
  });

  test('compares by type and id', () {
    expect(
      const NotificationTarget.debt('a'),
      const NotificationTarget.debt('a'),
    );
    expect(
      const NotificationTarget.debt('a').hashCode,
      const NotificationTarget.debt('a').hashCode,
    );
    expect(
      const NotificationTarget.debt('a'),
      isNot(const NotificationTarget.team('a')),
    );
    expect(const NotificationTarget.debt('a').toString(), contains('debt'));
  });
}
