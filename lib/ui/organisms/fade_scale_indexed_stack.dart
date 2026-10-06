import 'package:flutter/material.dart';

import '../../core/utils/reduced_motion.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';

/// Shows one child at a time, like `IndexedStack`, but keeps every child
/// alive (scroll position, half-typed forms) and switches with a fade plus a
/// small scale-in. Hidden children don't paint, take focus, tick or read out.
class FadeScaleIndexedStack extends StatelessWidget {
  const FadeScaleIndexedStack({
    super.key,
    required this.index,
    required this.children,
  });

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
  const _Page({
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
          child: TickerMode(
            enabled: active,
            child: AnimatedOpacity(
              opacity: active ? 1 : 0,
              duration: duration,
              curve: AppCurves.select,
              child: AnimatedScale(
                scale: active ? 1 : 0.96,
                duration: duration,
                curve: AppCurves.gentle,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
