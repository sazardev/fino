import 'package:flutter/material.dart';

import '../../domain/auth_user.dart';
import '../../domain/avatar_initials.dart';

/// The person's Google photo, or a generated avatar (initials on a tone that
/// is always the same for the same user, SPEC U3) when there is none.
class ProfileAvatar extends StatelessWidget {
  const new({required this.user, super.key, this.size = 64});

  final AuthUser user;
  final double size;

  @override
  Widget build(BuildContext context) {
    final photo = user.photoUrl;
    final fallback = _Initials(user: user, size: size);

    return SizedBox.square(
      dimension: size,
      child: ClipOval(
        child: photo == null
            ? fallback
            : Image.network(
                photo,
                fit: BoxFit.cover,
                cacheWidth: (size * MediaQuery.devicePixelRatioOf(context))
                    .round(),
                errorBuilder: (_, _, _) => fallback,
              ),
      ),
    );
  }
}

class _Initials extends StatelessWidget {
  const new({required this.user, required this.size});

  final AuthUser user;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Tones come from the colour scheme: they follow accent and dark mode.
    final tones = [
      (scheme.primaryContainer, scheme.onPrimaryContainer),
      (scheme.secondaryContainer, scheme.onSecondaryContainer),
      (scheme.tertiaryContainer, scheme.onTertiaryContainer),
    ];
    final (background, foreground) =
        tones[_stableHash(user.uid) % tones.length];

    return ColoredBox(
      color: background,
      child: Center(
        child: Text(
          AvatarInitials.of(user),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w700,
            fontSize: size * 0.36,
          ),
        ),
      ),
    );
  }

  // `String.hashCode` is not stable between runs; the avatar must be.
  static int _stableHash(String text) =>
      text.codeUnits.fold(0, (hash, unit) => (hash * 31 + unit) & 0x7fffffff);
}
