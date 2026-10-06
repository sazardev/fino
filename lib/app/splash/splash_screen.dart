import 'package:flutter/material.dart';

import '../../core/utils/reduced_motion.dart';
import '../../ui/brand/fino_mark.dart';
import '../../ui/navigation/app_page_route.dart';
import '../../ui/responsive/responsive.dart';

/// Cold-start splash: the logo builds itself, the wordmark settles in beneath
/// it, then the app fades in. Tap to skip.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.next});

  /// The screen to show afterwards.
  final Widget next;

  static const duration = Duration(milliseconds: 1900);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: SplashScreen.duration,
  );
  late final Animation<double> _mark = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.0, 0.68),
  );
  late final Animation<double> _word = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.55, 0.85, curve: Curves.easeOutCubic),
  );
  bool _left = false;

  @override
  void initState() {
    super.initState();
    _c.addStatusListener((s) {
      if (s == AnimationStatus.completed) _leave();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Reduced motion: no build, just the finished logo for a moment.
      if (context.reduceMotion) {
        _c.value = 1;
      } else {
        _c.forward();
      }
    });
  }

  void _leave() {
    if (_left || !mounted) return;
    _left = true;
    Navigator.of(context).pushReplacement(appPageRoute((_) => widget.next));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = (Responsive.of(context).size.shortestSide * 0.34).clamp(
      72.0,
      220.0,
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _leave,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FinoMark(progress: _mark, size: size),
              SizedBox(height: size * 0.22),
              AnimatedBuilder(
                animation: _word,
                builder: (context, child) => Opacity(
                  opacity: _word.value,
                  child: Transform.translate(
                    offset: Offset(0, 10 * (1 - _word.value)),
                    child: child,
                  ),
                ),
                child: Text(
                  'fino',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 8,
                    fontSize: (size * 0.2).clamp(18.0, 40.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
