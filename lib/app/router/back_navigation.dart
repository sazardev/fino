import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// What the back button of a secondary screen does. Each route says where
/// back leads, so a screen never asks the navigator whether it can go back.
abstract final class BackNavigation {
  const new _();

  /// Goes one screen back: pops when there is a screen below (always the
  /// case when we got here by tapping, and what the browser's back does),
  /// otherwise goes to [fallback], so a deep link, a refreshed web page or a
  /// notification never strands the person on a screen with no way out.
  static VoidCallback to(BuildContext context, {required String fallback}) {
    final router = GoRouter.of(context);
    return () => router.canPop() ? router.pop() : router.go(fallback);
  }
}
