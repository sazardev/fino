import 'package:flutter/material.dart';

import '../atoms/app_icon_button.dart';

/// Back arrow that floats over the content of a secondary screen (there is no
/// top bar). A tonal circle keeps it readable over whatever scrolls beneath.
class FloatingBackButton extends StatelessWidget {
  const new({required this.onPressed, super.key});

  /// Where back leads is the route's call, not the button's.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: AppIconButton(
        tooltip: 'Volver',
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}
