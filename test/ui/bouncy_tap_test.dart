import 'package:fino/core/haptics/haptic_engine.dart';
import 'package:fino/core/haptics/haptics.dart';
import 'package:fino/ui/atoms/bouncy_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeEngine implements HapticEngine {
  final calls = <String>[];
  @override
  void light() => calls.add('light');
  @override
  void medium() => calls.add('medium');
  @override
  void heavy() => calls.add('heavy');
  @override
  void selection() => calls.add('selection');
}

void main() {
  late _FakeEngine engine;

  setUp(() {
    engine = _FakeEngine();
    Haptics.engine = engine;
    Haptics.enabled = true;
    Haptics.resetForTest();
  });

  Future<void> pumpTap(WidgetTester tester, {VoidCallback? onTap}) =>
      tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: BouncyTap(
              onTap: onTap,
              child: const ColoredBox(
                key: Key('target'),
                color: Colors.red,
                child: SizedBox(width: 100, height: 100),
              ),
            ),
          ),
        ),
      );

  double paintedScale(WidgetTester tester) => tester
      .widget<Transform>(
        find.descendant(
          of: find.byType(BouncyTap),
          matching: find.byType(Transform),
        ),
      )
      .transform
      .entry(0, 0);

  testWidgets('shrinks while pressed and springs back', (tester) async {
    await pumpTap(tester, onTap: () {});

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(const Key('target'))),
    );
    // The press registers after kPressTimeout; the spring needs frames after.
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 200));
    expect(paintedScale(tester), closeTo(0.92, 0.001));

    await gesture.up();
    await tester.pumpAndSettle();
    expect(paintedScale(tester), closeTo(1.0, 0.001));
  });

  testWidgets('fires onTap and a tap haptic', (tester) async {
    var taps = 0;
    await pumpTap(tester, onTap: () => taps++);

    await tester.tap(find.byKey(const Key('target')));
    await tester.pumpAndSettle();

    expect(taps, 1);
    expect(engine.calls, ['light']);
  });

  testWidgets('does nothing without a callback', (tester) async {
    await pumpTap(tester);

    await tester.tap(find.byKey(const Key('target')));
    await tester.pumpAndSettle();

    expect(engine.calls, isEmpty);
  });

  testWidgets('stays silent when haptics are off', (tester) async {
    Haptics.enabled = false;
    await pumpTap(tester, onTap: () {});

    await tester.tap(find.byKey(const Key('target')));
    await tester.pumpAndSettle();

    expect(engine.calls, isEmpty);
  });
}
