import 'package:flutter/material.dart';

import '../../../../ui/design/app_spacing.dart';

/// The one action of the sign-in screen: continue with Google.
class GoogleSignInButton extends StatelessWidget {
  const new({required this.onPressed, required this.busy, super.key});

  final VoidCallback onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: busy ? null : onPressed,
      icon: busy
          ? const SizedBox.square(
              dimension: AppSpacing.xl,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.login_rounded),
      label: const Text('Continuar con Google'),
    );
  }
}
