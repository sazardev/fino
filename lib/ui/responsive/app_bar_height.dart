import 'package:flutter/material.dart';

import 'form_factor.dart';
import 'responsive.dart';

/// Toolbar height for the current screen class.
double appBarHeightFor(Responsive r) => switch (r.factor) {
  FormFactor.watch => 40,
  FormFactor.compact => kToolbarHeight,
  FormFactor.medium => 60,
  FormFactor.expanded => 64,
};
