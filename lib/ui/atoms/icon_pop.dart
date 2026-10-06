import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/utils/reduced_motion.dart';
import '../design/app_curves.dart';

/// Squashes [child], springs it past its size and settles with a small wobble
/// every time [trigger] changes.
class IconPop extends StatefulWidget {
  const IconPop({super.key, required this.trigger, required this.child});

  final int trigger;
  final Widget child;

  @override
  State<IconPop> createState() => _IconPopState();
}

class _IconPopState extends State<IconPop> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 620),
  );

  late final Animation<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 1.0,
        end: 0.72,
      ).chain(CurveTween(curve: AppCurves.select)),
      weight: 18,
    ),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 0.72,
        end: 1.0,
      ).chain(CurveTween(curve: AppCurves.bouncy)),
      weight: 82,
    ),
  ]).animate(_controller);

  @override
  void didUpdateWidget(covariant IconPop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trigger != widget.trigger && !context.reduceMotion) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final t = _controller.value;
        return Transform.rotate(
          angle: math.sin(t * math.pi * 3) * 0.16 * (1 - t),
          child: Transform.scale(scale: _scale.value, child: child),
        );
      },
    );
  }
}
