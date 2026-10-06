import 'package:flutter/widgets.dart';

/// Shared corner-radius scale. Everything rounded uses one of these.
abstract final class AppRadii {
  const AppRadii._();

  static const double sm = 14;
  static const double md = 20;
  static const double lg = 28;

  static const BorderRadius smRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdRadius = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgRadius = BorderRadius.all(Radius.circular(lg));

  static const StadiumBorder pill = StadiumBorder();
}
