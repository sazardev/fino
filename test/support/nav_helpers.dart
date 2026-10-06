import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Taps a primary destination by icon (labels are hidden on a watch). Looks
/// only inside the bar or rail: the same icon may appear in page content.
Future<void> goTo(WidgetTester tester, IconData icon) async {
  final navigation = find.byWidgetPredicate(
    (widget) => widget is NavigationBar || widget is NavigationRail,
  );
  await tester.tap(
    find.descendant(of: navigation, matching: find.byIcon(icon)).first,
    // On a watch the unread badge covers the icon; it is inside the same
    // destination, so the tap still selects it.
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();
}

const IconData homeIcon = Icons.home_rounded;
const IconData ordersIcon = Icons.receipt_long_rounded;
const IconData inboxIcon = Icons.inbox_rounded;
const IconData settingsIcon = Icons.tune_rounded;

Future<void> resizeTo(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  await tester.pumpAndSettle();
}
