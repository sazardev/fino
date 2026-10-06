import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/auth_state_provider.dart';
import '../../features/teams/presentation/widgets/teams_section.dart';

/// Hands the signed-in person's id to the teams feature, which cannot import
/// auth itself.
class SignedInTeamsSection extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authStateProvider.select((a) => a.value?.uid));
    if (uid == null) return const SizedBox.shrink();

    return TeamsSection(userId: uid);
  }
}
