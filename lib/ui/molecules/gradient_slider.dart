import 'package:flutter/material.dart';

import '../design/app_spacing.dart';

/// Labeled slider over a gradient track (functional: it previews the value).
class GradientSlider extends StatelessWidget {
  const GradientSlider({
    super.key,
    required this.label,
    required this.value,
    required this.max,
    required this.colors,
    required this.thumbColor,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double max;
  final List<Color> colors;
  final Color thumbColor;
  final ValueChanged<double> onChanged;

  static const double _trackHeight = 14;
  static const double _thumbInset = 10;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xs),
          child: Text(label, style: text.bodySmall),
        ),
        SizedBox(
          height: 32,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _thumbInset),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_trackHeight),
                    gradient: LinearGradient(colors: colors),
                  ),
                  child: const SizedBox(
                    height: _trackHeight,
                    width: double.infinity,
                  ),
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: _trackHeight,
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  thumbColor: thumbColor,
                ),
                child: Slider(value: value, max: max, onChanged: onChanged),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
