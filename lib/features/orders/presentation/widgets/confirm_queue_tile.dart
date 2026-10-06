import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/directory/people_provider.dart';
import '../../../../core/format/money_format.dart';
import '../../../../core/money/money.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/app_button_tone.dart';
import '../../domain/enums/review_decision.dart';
import '../navigation/orders_navigator_provider.dart';
import '../providers/commands/review_debts_command_provider.dart';
import '../providers/person_balance.dart';
import '../text/describe_order_error.dart';

/// "Ana dice que ya te pagó $145": confirmarlo de golpe o revisarlo (G5).
class ConfirmQueueTile extends ConsumerWidget {
  const new({required this.balance, super.key});

  final PersonBalance balance;

  Future<void> _confirmAll(BuildContext context, WidgetRef ref) => runAction(
    context,
    () => ref.read(reviewDebtsCommandProvider)(
      actorId: ref.read(sessionUserIdProvider)!,
      decisions: [
        for (final debt in balance.reported)
          (debtId: debt.id, decision: ReviewDecision.confirm, note: null),
      ],
    ),
    success: 'Pago confirmado',
    describe: describeOrderError,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final key = DirectoryPerson.keyOf(balance.teamId, balance.userId);
    final name = ref.watch(
      peopleProvider.select((p) => p.value?[key]?.displayName ?? 'Alguien'),
    );
    final amount = MoneyFormat.format(
      Money.sum(balance.reported.map((d) => d.amount)),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: AppRadii.mdRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '$name dice que ya te pagó $amount',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: scheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppButton(
                label: 'Confirmar',
                icon: Icons.check_rounded,
                onPressed: () => _confirmAll(context, ref),
              ),
              AppButton(
                label: 'Revisar',
                tone: AppButtonTone.tonal,
                onPressed: () => ref
                    .read(ordersNavigatorProvider)
                    .openCounterpart(balance.teamId, balance.userId),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
