import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../../core/utils/reduced_motion.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';
import '../design/app_radii.dart';
import 'focus_halo.dart';

/// Flat press feedback: scales [child] down on press and springs it back on
/// release. No ink ripple; feedback is motion plus a haptic tap.
///
/// Focusable, so a keyboard, D-pad or rotary can reach and activate it.
class BouncyTap extends StatefulWidget {
  const BouncyTap({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.pressedScale = 0.92,
    this.enableFeedback = true,
    this.behavior = HitTestBehavior.opaque,
    this.focusBorderRadius = AppRadii.mdRadius,
    this.autofocus = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressedScale;
  final bool enableFeedback;
  final HitTestBehavior behavior;

  /// Shape of the focus halo. Match the child's shape.
  final BorderRadius focusBorderRadius;

  /// Takes focus when first shown, as a starting point for keys / D-pad.
  final bool autofocus;

  @override
  State<BouncyTap> createState() => _BouncyTapState();
}

class _BouncyTapState extends State<BouncyTap>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.fast,
  );
  late final CurvedAnimation _curved = CurvedAnimation(
    parent: _controller,
    curve: AppCurves.select,
    reverseCurve: AppCurves.bouncy,
  );
  late final Animation<double> _scale = _curved.drive(
    Tween<double>(begin: 1.0, end: widget.pressedScale),
  );

  bool _focused = false;

  bool get _enabled => widget.onTap != null || widget.onLongPress != null;

  void _press() {
    if (!_enabled) return;
    context.reduceMotion ? _controller.value = 1 : _controller.forward();
    if (widget.enableFeedback) Haptics.tap();
  }

  void _release() {
    if (!_enabled) return;
    context.reduceMotion ? _controller.value = 0 : _controller.reverse();
  }

  void _longPress() {
    Haptics.confirm();
    widget.onLongPress!();
  }

  @override
  void dispose() {
    _curved.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      enabled: widget.onTap != null,
      autofocus: widget.autofocus,
      mouseCursor: _enabled ? SystemMouseCursors.click : MouseCursor.defer,
      onShowFocusHighlight: (focused) => setState(() => _focused = focused),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onTap?.call();
            return null;
          },
        ),
      },
      child: GestureDetector(
        behavior: widget.behavior,
        onTapDown: (_) => _press(),
        onTapUp: (_) => _release(),
        onTapCancel: _release,
        onTap: widget.onTap,
        onLongPress: widget.onLongPress == null ? null : _longPress,
        child: AnimatedBuilder(
          animation: _scale,
          builder: (context, child) => Transform.scale(
            scale: _scale.value * (_focused ? 1.05 : 1.0),
            child: child,
          ),
          child: FocusHalo(
            visible: _focused,
            borderRadius: widget.focusBorderRadius,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
