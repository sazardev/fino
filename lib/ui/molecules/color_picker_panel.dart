import 'package:flutter/material.dart';

import '../design/app_spacing.dart';
import 'gradient_slider.dart';
import 'hex_field.dart';

/// Inline custom-color picker (no dialog): hue / saturation / brightness
/// sliders plus a hex field. Reports every change.
class ColorPickerPanel extends StatefulWidget {
  const ColorPickerPanel({
    super.key,
    required this.color,
    required this.onChanged,
  });

  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  State<ColorPickerPanel> createState() => _ColorPickerPanelState();
}

class _ColorPickerPanelState extends State<ColorPickerPanel> {
  // HSV is the source of truth: round-tripping through RGB would lose the hue
  // whenever saturation or brightness hits 0.
  late HSVColor _hsv = HSVColor.fromColor(widget.color);

  void _set(HSVColor hsv) {
    setState(() => _hsv = hsv);
    widget.onChanged(hsv.toColor());
  }

  @override
  Widget build(BuildContext context) {
    final h = _hsv.hue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GradientSlider(
          label: 'Tono',
          value: h,
          max: 360,
          thumbColor: HSVColor.fromAHSV(1, h, 1, 1).toColor(),
          colors: [
            for (var i = 0; i <= 6; i++)
              HSVColor.fromAHSV(1, i * 60.0, 1, 1).toColor(),
          ],
          onChanged: (v) => _set(_hsv.withHue(v)),
        ),
        GradientSlider(
          label: 'Saturación',
          value: _hsv.saturation,
          max: 1,
          thumbColor: _hsv.toColor(),
          colors: [
            HSVColor.fromAHSV(1, h, 0, _hsv.value).toColor(),
            HSVColor.fromAHSV(1, h, 1, _hsv.value).toColor(),
          ],
          onChanged: (v) => _set(_hsv.withSaturation(v)),
        ),
        GradientSlider(
          label: 'Brillo',
          value: _hsv.value,
          max: 1,
          thumbColor: _hsv.toColor(),
          colors: [
            Colors.black,
            HSVColor.fromAHSV(1, h, _hsv.saturation, 1).toColor(),
          ],
          onChanged: (v) => _set(_hsv.withValue(v)),
        ),
        const SizedBox(height: AppSpacing.sm),
        HexField(
          color: _hsv.toColor(),
          onChanged: (c) {
            setState(() => _hsv = HSVColor.fromColor(c));
            widget.onChanged(c);
          },
        ),
      ],
    );
  }
}
