import 'package:flutter/painting.dart';

extension TabularText on TextStyle {
  /// Fixed-width digits so amounts don't jitter while they animate and line
  /// up in columns.
  TextStyle get tabular =>
      copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
}
