import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/brand/fino_mark.dart';
import '../../../../ui/design/app_spacing.dart';
import '../providers/sign_in_controller.dart';
import '../widgets/google_sign_in_button.dart';

/// Where a signed-out person lands. Signing in sends them on (the router's
/// auth guard does the navigation).
class SignInPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FinoMark(
                    progress: AlwaysStoppedAnimation(1),
                    size: 120,
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  GoogleSignInButton(
                    busy: state.isLoading,
                    onPressed: ref
                        .read(signInControllerProvider.notifier)
                        .signIn,
                  ),
                  if (state.hasError) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'No pudimos iniciar sesión. Inténtalo de nuevo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.error),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
