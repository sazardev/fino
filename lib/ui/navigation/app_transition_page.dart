import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../design/app_curves.dart';
import '../design/app_durations.dart';

/// App-wide page transition: fade + gentle scale-in of the incoming page.
///
/// Deliberately not `FadeThrough` / `SharedAxis` / `MaterialPageRoute`: those
/// cross-fade through a solid `canvasColor` box that flashes white against a
/// vivid accent theme. This never inserts an intermediate solid box.
class AppTransitionPage<T> extends CustomTransitionPage<T> {
  const new({required super.child, super.key, super.name})
    : super(
        transitionDuration: AppDurations.medium,
        reverseTransitionDuration: AppDurations.medium,
        transitionsBuilder: _transition,
      );

  static Widget _transition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(parent: animation, curve: AppCurves.gentle);
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
        child: child,
      ),
    );
  }
}
