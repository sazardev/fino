import 'package:flutter/material.dart';

import '../../ui/design/app_durations.dart';
import 'splash_screen.dart';

/// Plays the splash over the app on cold start, whatever route a deep link
/// opened underneath, then fades it away.
class SplashGate extends StatefulWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        AnimatedSwitcher(
          duration: AppDurations.medium,
          child: _done
              ? const SizedBox.shrink()
              : SplashScreen(onFinished: () => setState(() => _done = true)),
        ),
      ],
    );
  }
}
