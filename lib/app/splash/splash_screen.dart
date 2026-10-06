import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/reduced_motion.dart';
import '../../ui/brand/fino_mark.dart';
import '../../ui/brand/fino_mark_painter.dart';
import '../../ui/responsive/responsive.dart';

/// Cold-start splash: on an accent background the "F" writes itself in white
/// ink, holds for a beat, then the app fades in. Tap to skip.
class SplashScreen extends StatefulWidget {
  const new({required this.onFinished, super.key});

  /// Called once, when the splash ends or is skipped.
  final VoidCallback onFinished;

  static const duration = Duration(milliseconds: 1500);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: SplashScreen.duration,
  );
  // The rest of the timeline is a short hold on the finished letter.
  static const _markEnd = 0.85;
  late final Animation<double> _mark = CurvedAnimation(
    parent: _c,
    curve: const Interval(0, _markEnd),
  );
  bool _left = false;

  @override
  void initState() {
    super.initState();
    FinoMarkPainter.warmUp();
    _c.addStatusListener((s) {
      if (s == AnimationStatus.completed) _leave();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Reduced motion: skip the writing and only hold the finished logo.
      if (context.reduceMotion) _c.value = _markEnd;
      _c.forward();
    });
  }

  void _leave() {
    if (_left || !mounted) return;
    _left = true;
    widget.onFinished();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = (Responsive.of(context).size.shortestSide * 0.72).clamp(
      120.0,
      520.0,
    );
    final overlay =
        ThemeData.estimateBrightnessForColor(scheme.primary) == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _leave,
        child: Scaffold(
          backgroundColor: scheme.primary,
          body: Center(
            child: FinoMark(
              progress: _mark,
              size: size,
              color: scheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
