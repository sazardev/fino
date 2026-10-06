import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/molecules/settings_row.dart';
import '../../data/inbox_repository_provider.dart';
import '../providers/unread_count_provider.dart';

/// "Marcar todo como leído", solo si hay algo sin leer.
class MarkAllReadRow extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadCountProvider).value ?? 0;
    if (unread == 0) return const SizedBox.shrink();

    return SettingsRow(
      label: unread == 1 ? '1 sin leer' : '$unread sin leer',
      subtitle: 'Marcar todo como leído',
      trailing: const Icon(Icons.done_all_rounded),
      onTap: () {
        final me = ref.read(sessionUserIdProvider);
        if (me != null) {
          unawaited(ref.read(inboxRepositoryProvider).markAllRead(me));
        }
      },
    );
  }
}
