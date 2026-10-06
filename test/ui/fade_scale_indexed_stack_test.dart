import 'package:fino/ui/organisms/fade_scale_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget stack(int index) => MaterialApp(
    home: FadeScaleIndexedStack(
      index: index,
      children: const [Text('uno'), Text('dos'), Text('tres')],
    ),
  );

  /// The opacity actually painted for the page showing [text] (not the target
  /// the page is animating towards).
  double paintedOpacity(WidgetTester tester, String text) => tester
      .widget<FadeTransition>(
        find
            .ancestor(
              of: find.text(text, skipOffstage: false),
              matching: find.byType(FadeTransition),
            )
            .first,
      )
      .opacity
      .value;

  testWidgets('the page that leaves fades out completely', (tester) async {
    await tester.pumpWidget(stack(2));
    await tester.pumpAndSettle();
    expect(paintedOpacity(tester, 'tres'), 1);

    await tester.pumpWidget(stack(0));
    await tester.pumpAndSettle();

    // Regression: muting its tickers froze the leaving page at full opacity,
    // leaving it painted over the page that took its place.
    expect(paintedOpacity(tester, 'tres'), 0);
    expect(paintedOpacity(tester, 'uno'), 1);
  });

  testWidgets('every page stays mounted while hidden', (tester) async {
    await tester.pumpWidget(stack(1));
    await tester.pumpAndSettle();

    expect(find.text('uno', skipOffstage: false), findsOneWidget);
    expect(find.text('tres', skipOffstage: false), findsOneWidget);
  });
}
