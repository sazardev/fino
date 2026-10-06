import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/directory/people_provider.dart';
import '../../../../core/directory/person_label.dart';
import '../../../../core/format/date_label.dart';
import '../../../../core/format/money_format.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../core/time/clock_provider.dart';
import '../../../../ui/atoms/person_avatar.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/amount_text.dart';
import '../../../../ui/molecules/status_pill.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/views/order_summary.dart';
import '../text/order_status_label.dart';

/// La cabecera del pedido: quién pagó, cuándo, cuánto, cómo va y la parte de
/// quien pagó (que no es deuda, P3).
class OrderSummaryCard extends ConsumerWidget {
  const new({required this.summary, super.key});

  final OrderSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final order = summary.order;
    final me = ref.watch(sessionUserIdProvider);
    final key = DirectoryPerson.keyOf(order.teamId, order.creditorId);
    final person = ref.watch(peopleProvider.select((p) => p.value?[key]));
    final payer = PersonLabel.of(
      {key: ?person},
      teamId: order.teamId,
      userId: order.creditorId,
      me: me,
    );
    final when = DateLabel.of(order.spentAt, now: ref.watch(clockProvider)());
    final progress = summary.progress;
    final share = MoneyFormat.format(summary.creditorShare);
    final muted = text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AppRadii.lgRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PersonAvatar(
                name: person?.displayName ?? payer,
                seed: order.creditorId,
                photoUrl: person?.photoUrl,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  '${payer == 'Tú' ? 'Pagaste' : 'Pagó $payer'} · $when',
                  style: text.bodyLarge,
                ),
              ),
              StatusPill(
                OrderStatusLabel.of(summary.status),
                strong: summary.status == OrderStatus.open,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AmountText(order.total, style: text.headlineMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${progress.confirmed} de ${progress.total} pagadas · '
            '${payer == 'Tú' ? 'Tu parte' : 'Su parte'}: $share',
            style: muted,
          ),
          if (order.note case final note?) ...[
            const SizedBox(height: AppSpacing.md),
            Text(note, style: text.bodyMedium),
          ],
        ],
      ),
    );
  }
}
