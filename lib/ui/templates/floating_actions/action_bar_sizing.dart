import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../design/app_spacing.dart';
import '../../organisms/action_bar_metrics.dart';
import '../../responsive/responsive.dart';

/// Large, easy targets that shrink only as much as needed to all fit.
double actionButtonSize({
  required Responsive r,
  required Size box,
  required bool vertical,
  required int count,
}) {
  final n = math.max(1, count);
  final available = vertical
      ? box.height - AppSpacing.lg * 2
      : box.width - AppSpacing.sm * 2;
  final fit = (available - kActionPad * 2 - kActionGap * (n - 1)) / n;
  final ideal = (vertical ? 64.0 : 56.0) * math.min(r.scale, 1.25);
  return math.max(36.0, math.min(ideal, fit));
}

/// Space reserved on BOTH sides of the content so it stays centred and never
/// runs under the buttons.
double actionBarReserve({
  required Responsive r,
  required double buttonSize,
  required bool vertical,
}) =>
    buttonSize +
    kActionPad * 2 +
    (vertical ? r.pagePadding : AppSpacing.lg) +
    AppSpacing.sm;

/// Tablets in any orientation and anything landscape-wide get the vertical
/// bar on the right; portrait phones keep it at the bottom.
bool useActionRail(Responsive r) => r.isWide || r.size.shortestSide >= 600;
