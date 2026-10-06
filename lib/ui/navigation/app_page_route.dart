import 'package:flutter/material.dart';

import '../design/app_curves.dart';
import '../design/app_durations.dart';

/// App-wide page transition: fade + gentle scale-in of the incoming page.
///
/// Deliberately not `FadeThrough` / `SharedAxis` / `MaterialPageRoute`: those
/// cross-fade through a solid `canvasColor` box that flashes white against a
/// vivid accent theme. This never inserts an intermediate solid box.
Route<T> appPageRoute<T>(WidgetBuilder builder) {
  return PageRouteBuilder<T>(
    transitionDuration: AppDurations.medium,
    reverseTransitionDuration: AppDurations.medium,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: AppCurves.gentle,
      );
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}
