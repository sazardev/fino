import 'package:flutter/widgets.dart';

import '../../ui/navigation/app_page_route.dart';
import 'can_pop_observer.dart';

/// Gives one destination its own navigation stack, so a detail opens *inside*
/// the destination and the navigation bar / rail stays visible. The system
/// back gesture pops this stack first.
class DestinationNavigator extends StatefulWidget {
  const DestinationNavigator({
    super.key,
    required this.navigatorKey,
    required this.root,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  /// The destination's first page.
  final Widget root;

  @override
  State<DestinationNavigator> createState() => _DestinationNavigatorState();
}

class _DestinationNavigatorState extends State<DestinationNavigator> {
  final _canPop = ValueNotifier<bool>(false);
  late final _observer = CanPopObserver(_canPop);

  @override
  void dispose() {
    _canPop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _canPop,
      builder: (context, canPop, child) => NavigatorPopHandler(
        enabled: canPop,
        onPopWithResult: (_) => widget.navigatorKey.currentState?.maybePop(),
        child: child!,
      ),
      child: Navigator(
        key: widget.navigatorKey,
        observers: [_observer],
        onGenerateRoute: (_) => appPageRoute((_) => widget.root),
      ),
    );
  }
}
