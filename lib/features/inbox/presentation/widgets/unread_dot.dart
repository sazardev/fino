import 'package:flutter/material.dart';

/// El puntito de "sin leer" (acompaña al texto en negritas: no solo color).
class UnreadDot extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Sin leer',
      child: Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
