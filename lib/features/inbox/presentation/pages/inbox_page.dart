import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/templates/list_shell.dart';
import '../providers/inbox_notifications_provider.dart';
import '../widgets/mark_all_read_row.dart';
import '../widgets/notification_tile.dart';

/// El buzón: todo lo que me avisaron, aunque el push no llegue (SPEC N2). Sin
/// título: la navegación ya dice "Buzón".
class InboxPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(inboxNotificationsProvider);
    final list = notifications.value ?? const [];

    return ListShell(
      loaded: notifications.hasValue,
      header: const [MarkAllReadRow()],
      itemCount: list.length,
      itemBuilder: (context, i) => NotificationTile(notification: list[i]),
      empty: const EmptyState(
        icon: Icons.notifications_none_rounded,
        title: 'Nada nuevo',
        hint: 'Aquí verás pedidos, pagos y avisos de tus equipos.',
      ),
    );
  }
}
