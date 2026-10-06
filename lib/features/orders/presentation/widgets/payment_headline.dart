import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/people_provider.dart';
import '../../../../core/directory/person_label.dart';
import '../../../../core/format/date_label.dart';
import '../../../../core/money/money.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../core/time/clock_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/amount_text.dart';
import '../../domain/entities/payment.dart';

/// Quién avisó que pagó, a quién, cuánto y cuándo: lo primero que se lee.
class PaymentHeadline extends ConsumerWidget {
  const new({required this.payment, required this.total, super.key});

  final Payment payment;
  final Money total;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(sessionUserIdProvider);
    final people = ref.watch(peopleProvider).value ?? const {};
    String name(String userId) =>
        PersonLabel.of(people, teamId: payment.teamId, userId: userId, me: me);
    final iAmCreditor = me == payment.creditorId;
    final text = Theme.of(context).textTheme;
    final when = DateLabel.of(
      payment.reportedAt,
      now: ref.watch(clockProvider)(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            iAmCreditor
                ? '${name(payment.debtorId)} dice que te pagó'
                : 'Le avisaste a ${name(payment.creditorId)} que pagaste',
            style: text.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          AmountText(total, direction: iAmCreditor, style: text.displaySmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            when,
            style: text.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
