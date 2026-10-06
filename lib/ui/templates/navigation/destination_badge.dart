import 'package:flutter/material.dart';

/// El número de pendientes sobre el ícono de un destino (se oculta en 0).
class DestinationBadge extends StatelessWidget {
  const new({required this.count, required this.child, super.key});

  final int count;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return child;
    return Badge.count(count: count, maxCount: 99, child: child);
  }
}
