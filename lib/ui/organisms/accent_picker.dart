import 'package:flutter/material.dart';

import '../atoms/accent_swatch.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';
import '../design/app_spacing.dart';
import '../molecules/color_picker_panel.dart';
import '../molecules/custom_accent_swatch.dart';

/// Accent-color choices: palette swatches plus a custom color with an inline
/// HSV / hex picker. Controlled through [color] and [onChanged].
class AccentPicker extends StatefulWidget {
  const new({
    required this.colors,
    required this.color,
    required this.onChanged,
    super.key,
    this.swatchSize = 52,
  });

  final List<Color> colors;
  final Color color;
  final ValueChanged<Color> onChanged;
  final double swatchSize;

  @override
  State<AccentPicker> createState() => _AccentPickerState();
}

class _AccentPickerState extends State<AccentPicker> {
  /// The user's custom color, if the accent isn't a palette color.
  late Color? _custom = _inPalette(widget.color) ? null : widget.color;
  late bool _customOpen = _custom != null;

  bool _inPalette(Color color) =>
      widget.colors.any((c) => c.toARGB32() == color.toARGB32());

  @override
  void didUpdateWidget(covariant AccentPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color == widget.color) return;
    if (_inPalette(widget.color)) {
      _customOpen = false;
    } else {
      _custom = widget.color;
      _customOpen = true;
    }
  }

  void _pickPalette(Color color) {
    setState(() => _customOpen = false);
    widget.onChanged(color);
  }

  void _openCustom() {
    setState(() {
      _custom ??= widget.color;
      _customOpen = true;
    });
    widget.onChanged(_custom!);
  }

  void _changeCustom(Color color) {
    setState(() => _custom = color);
    widget.onChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    final gap = widget.swatchSize < 48 ? AppSpacing.sm : AppSpacing.md;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final c in widget.colors)
              AccentSwatch(
                color: c,
                size: widget.swatchSize,
                selected:
                    !_customOpen && c.toARGB32() == widget.color.toARGB32(),
                onTap: () => _pickPalette(c),
              ),
            CustomAccentSwatch(
              size: widget.swatchSize,
              color: _custom,
              selected: _customOpen,
              onTap: _openCustom,
            ),
          ],
        ),
        AnimatedSize(
          duration: AppDurations.medium,
          curve: AppCurves.settle,
          child: _customOpen
              ? Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xl),
                  child: ColorPickerPanel(
                    color: _custom!,
                    onChanged: _changeCustom,
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
