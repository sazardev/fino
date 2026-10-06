import 'package:fino/ui/design/spring_curve.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every spring starts at 0 and settles at 1', () {
    for (final curve in [
      SpringCurve.bouncy,
      SpringCurve.snappy,
      SpringCurve.gentle,
    ]) {
      expect(curve.transform(0), 0);
      expect(curve.transform(1), closeTo(1, 0.05));
    }
  });

  test('bouncy overshoots, gentle overshoots less', () {
    double peak(SpringCurve c) =>
        [for (var i = 1; i < 100; i++) c.transform(i / 100)]
            .reduce((a, b) => a > b ? a : b);

    expect(peak(SpringCurve.bouncy), greaterThan(1.2));
    expect(peak(SpringCurve.gentle), lessThan(peak(SpringCurve.bouncy)));
  });

  test('an over-damped spring never overshoots', () {
    const curve = SpringCurve(mass: 1, stiffness: 100, damping: 40);
    for (var i = 0; i <= 100; i++) {
      expect(curve.transform(i / 100), lessThanOrEqualTo(1.0001));
    }
  });
}
