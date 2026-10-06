import 'package:fino/ui/responsive/form_factor.dart';
import 'package:fino/ui/responsive/responsive.dart';
import 'package:fino/ui/responsive/ui_size.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('classifies the window by size alone', () {
    FormFactor of(double w, double h) => Responsive.fromSize(Size(w, h)).factor;

    expect(of(200, 200), FormFactor.watch);
    expect(of(390, 844), FormFactor.compact);
    expect(of(700, 400), FormFactor.medium);
    expect(of(1280, 800), FormFactor.expanded);
  });

  test('phones stay at scale 1, big screens grow up to 1.5', () {
    expect(Responsive.fromSize(const Size(390, 844)).scale, 1.0);
    expect(Responsive.fromSize(const Size(3000, 2000)).scale, 1.5);
  });

  test('the UI size multiplies the scale', () {
    final r = Responsive.fromSize(
      const Size(390, 844),
      uiSize: UiSize.extraLarge,
    );
    expect(r.scale, 1.5);
  });

  test('content never gets wider than the window', () {
    expect(
      Responsive.fromSize(
        const Size(300, 600),
        uiSize: UiSize.extraLarge,
      ).contentWidth,
      300,
    );
  });
}
