import 'package:flutter/material.dart';

/// Shown instead of the app when startup fails, so a broken build says why
/// rather than staying blank.
class BootstrapFailureApp extends StatelessWidget {
  const new({required this.error, super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SelectableText(
                'Fino no pudo iniciar.\n\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
