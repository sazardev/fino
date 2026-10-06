import 'package:flutter/widgets.dart';

/// One primary destination: a rounded icon and a one-word label.
class AppDestination {
  const new({required this.icon, required this.label, this.badge = 0});

  final IconData icon;
  final String label;

  /// Cuántas cosas pendientes tiene (0 = sin número).
  final int badge;
}
