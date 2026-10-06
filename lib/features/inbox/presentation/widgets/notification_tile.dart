import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/people_provider.dart';
import '../../../../core/directory/person_label.dart';
import '../../../../core/format/date_label.dart';
import '../../../../core/time/clock_provider.dart';
import '../../../../ui/atoms/bouncy_tap.dart';
import '../../../../ui/atoms/icon_badge.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../data/inbox_repository_provider.dart';
import '../../domain/entities/inbox_notification.dart';
import '../navigation/inbox_navigator_provider.dart';
import '../text/notification_icon.dart';
import '../text/notification_text.dart';
import 'unread_dot.dart';

/// Una notificación: qué pasó, cuándo y si ya la vi. Tocarla la marca leída
/// y lleva a lo que cambió; deslizarla la borra.
class NotificationTile extends ConsumerWidget {
  const new({required this.notification, super.key});

  final InboxNotification notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final intent = notification.intent;
    final unread = notification.readAt == null;
    final people = ref.watch(peopleProvider).value ?? const {};
    final actor = PersonLabel.of(
      people,
      teamId: intent.teamId,
      userId: intent.actorId,
      me: intent.recipientId,
    );
    final repo = ref.read(inboxRepositoryProvider);
    final me = intent.recipientId;

    return Dismissible(
      key: ValueKey(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => unawaited(repo.remove(me, notification.id)),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.xl),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: AppRadii.mdRadius,
        ),
        child: Icon(Icons.delete_rounded, color: scheme.onErrorContainer),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: BouncyTap(
          pressedScale: 0.98,
          onTap: () {
            unawaited(repo.markRead(me, notification.id));
            unawaited(ref.read(inboxNavigatorProvider).openTarget(intent));
          },
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: unread
                  ? scheme.primaryContainer
                  : scheme.surfaceContainerHigh,
              borderRadius: AppRadii.mdRadius,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconBadge(icon: NotificationIcon.of(intent.kind)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        NotificationText.of(intent, actor: actor),
                        style: text.bodyMedium?.copyWith(
                          fontWeight: unread ? FontWeight.w600 : null,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        DateLabel.ago(
                          notification.createdAt,
                          now: ref.watch(clockProvider)(),
                        ),
                        style: text.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (unread) const UnreadDot(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
