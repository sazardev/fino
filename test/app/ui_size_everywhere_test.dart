import 'package:fino/ui/responsive/ui_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';
import '../support/nav_helpers.dart';

/// The text scale the app actually renders with, on the Settings screen.
double _textScale(WidgetTester tester) {
  final context = tester.element(find.text('Apariencia'));
  return MediaQuery.textScalerOf(context).scale(14) / 14;
}

void main() {
  const desktop = Size(1280, 800);

  Future<void> openSettings(WidgetTester tester) => goTo(tester, settingsIcon);

  testWidgets('S is S on a phone and on a desktop', (tester) async {
    await pumpFino(tester, stored: {'ui_size': UiSize.small.name});
    await openSettings(tester);
    final onPhone = _textScale(tester);

    await resizeTo(tester, desktop);
    expect(_textScale(tester), onPhone);
    expect(onPhone, UiSize.small.multiplier);
  });

  testWidgets('growing on big screens is opt-in', (tester) async {
    await pumpFino(
      tester,
      size: desktop,
      stored: {'ui_size': UiSize.small.name, 'adapt_to_screen': 'true'},
    );
    await openSettings(tester);

    expect(_textScale(tester), closeTo(1.5 * 0.9, 0.001));
  });
}
