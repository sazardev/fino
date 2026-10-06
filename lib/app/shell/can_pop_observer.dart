import 'package:flutter/widgets.dart';

/// Tells a nested navigator's owner whether it has a route to go back to.
class CanPopObserver extends NavigatorObserver {
  CanPopObserver(this.canPop);

  final ValueNotifier<bool> canPop;

  void _update() {
    // After the navigator settles: `canPop` is stale while routes change.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => canPop.value = navigator?.canPop() ?? false,
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _update();

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) => _update();

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _update();
}
