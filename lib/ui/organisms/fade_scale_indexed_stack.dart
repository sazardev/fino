import 'package:flutter/material.dart';

import '../../core/utils/reduced_motion.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';

/// Shows one child at a time, like `IndexedStack`, but keeps every child
/// alive (scroll position, half-typed forms) and switches with a fade plus a
/// small scale-in. Hidden children don't paint, take focus, tick or read out.
class FadeScaleIndexedStack extends StatelessWidget {
  const new({required this.index, required this.children, super.key});

  final int index;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final duration = context.reduceMotion ? Duration.zero : AppDurations.medium;

    return Stack(
      fit: StackFit.expand,
      children: [
        for (var i = 0; i < children.length; i++)
          _Page(active: i == index, duration: duration, child: children[i]),
      ],
    );
  }
}

class _Page extends StatelessWidget {
  const new({
    required this.active,
    required this.duration,
    required this.child,
  });

  final bool active;
  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      excluding: !active,
      child: IgnorePointer(
        ignoring: !active,
        child: ExcludeFocus(
          excluding: !active,
          child: AnimatedOpacity(
            opacity: active ? 1 : 0,
            duration: duration,
            curve: AppCurves.select,
            child: AnimatedScale(
              scale: active ? 1 : 0.96,
              duration: duration,
              curve: AppCurves.gentle,
              // Inside the fade: muting tickers *above* it would freeze the
              // leaving page's fade-out and leave it painted over the new one.
              child: TickerMode(enabled: active, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
