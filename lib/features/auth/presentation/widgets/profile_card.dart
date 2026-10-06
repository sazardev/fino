import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/atoms/pop_in.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/responsive/responsive.dart';
import '../../domain/auth_user.dart';
import '../providers/auth_state_provider.dart';
import 'profile_avatar.dart';

/// Who is signed in: avatar, name and email. Nothing is editable, both come
/// from Google (SPEC U2).
class ProfileCard extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    if (user == null) return const SizedBox.shrink();

    return _Card(user: user);
  }
}

class _Card extends StatelessWidget {
  const new({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final name = user.displayName;
    final email = user.email;
    final watch = Responsive.of(context).isWatch;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHigh,
          borderRadius: AppRadii.mdRadius,
        ),
        child: Padding(
          padding: EdgeInsets.all(watch ? AppSpacing.md : AppSpacing.lg),
          child: Row(
            children: [
              PopIn(
                child: ProfileAvatar(user: user, size: watch ? 40 : 64),
              ),
              SizedBox(width: watch ? AppSpacing.md : AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (name != null)
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    if (email != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
