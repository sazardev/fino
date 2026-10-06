import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Taps a primary destination by icon (labels are hidden on a watch).
Future<void> goTo(WidgetTester tester, IconData icon) async {
  await tester.tap(find.byIcon(icon).first);
  await tester.pumpAndSettle();
}

const IconData homeIcon = Icons.home_rounded;
const IconData galleryIcon = Icons.widgets_rounded;
const IconData settingsIcon = Icons.tune_rounded;

Future<void> resizeTo(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  await tester.pumpAndSettle();
}
