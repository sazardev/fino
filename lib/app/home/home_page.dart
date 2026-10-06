import 'package:flutter/material.dart';

import '../../ui/brand/fino_mark.dart';

/// Placeholder for the first destination. No title: the navigation already
/// says "Inicio". Real content replaces the mark.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: FinoMark(progress: AlwaysStoppedAnimation(1), size: 160),
        ),
      ),
    );
  }
}
