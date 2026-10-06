import 'package:flutter/material.dart';

import '../atoms/app_icon_button.dart';

/// Back arrow that floats over the content of a secondary screen (there is no
/// top bar). A tonal circle keeps it readable over whatever scrolls beneath.
class FloatingBackButton extends StatelessWidget {
  const FloatingBackButton({super.key, this.onPressed});

  /// Defaults to popping the nearest navigator.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: AppIconButton(
        tooltip: 'Volver',
        onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}
