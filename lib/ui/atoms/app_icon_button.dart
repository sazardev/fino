import 'package:flutter/material.dart';

import '../design/app_curves.dart';
import '../responsive/responsive.dart';
import 'app_icon_button_scope.dart';
import 'bouncy_tap.dart';
import 'chubby_icon.dart';
import 'icon_pop.dart';

/// Flat, round icon button with bouncy press feedback. [selected] fills the
/// circle with the primary color (an active toggle).
///
/// Plain [Icon]s are drawn plump (see [ChubbyIcon]). On tap, and whenever
/// [selected] flips, the icon pops with a small wobble.
class AppIconButton extends StatefulWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.selected = false,
    this.size,
    this.autofocus = false,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool selected;

  /// Diameter. Defaults to the toolbar's size, else the screen-aware one.
  final double? size;
  final bool autofocus;

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  int _pops = 0;

  void _handleTap() {
    setState(() => _pops++);
    widget.onPressed?.call();
  }

  @override
  void didUpdateWidget(covariant AppIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) _pops++;
  }

  Widget _plump(Widget icon) {
    if (icon is Icon && icon.icon != null) {
      return ChubbyIcon(icon.icon!, size: icon.size, color: icon.color);
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final r = Responsive.of(context);
    final size =
        widget.size ??
        AppIconButtonScope.sizeOf(context) ??
        (r.isWatch ? 34.0 : 44.0 * r.scale);
    final selected = widget.selected;

    final button = BouncyTap(
      onTap: widget.onPressed == null ? null : _handleTap,
      focusBorderRadius: BorderRadius.circular(size),
      pressedScale: 0.9,
      autofocus: widget.autofocus,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: AppCurves.select,
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? scheme.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: IconPop(
          trigger: _pops,
          child: IconTheme.merge(
            data: IconThemeData(
              color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
              size: size * 0.54,
            ),
            child: _plump(widget.icon),
          ),
        ),
      ),
    );

    if (widget.tooltip == null) return button;
    return Tooltip(message: widget.tooltip!, child: button);
  }
}
