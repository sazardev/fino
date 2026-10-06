import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/format/money_format.dart';
import '../../../../core/money/money.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/app_button_tone.dart';
import '../../domain/enums/review_decision.dart';
import '../navigation/orders_navigator_provider.dart';
import '../providers/commands/review_debts_command_provider.dart';
import '../providers/person_balance.dart';
import '../text/describe_order_error.dart';

/// Lo que se puede hacer con alguien: pagarle lo que le debo (G2), confirmar
/// lo que me reportó (G5) o recordarle lo que me debe (SPEC §8).
class CounterpartActions extends ConsumerWidget {
  const new({required this.iOwe, required this.owedToMe, super.key});

  final PersonBalance iOwe;
  final PersonBalance owedToMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = ref.read(ordersNavigatorProvider);
    final payable = Money.sum(iOwe.payable.map((d) => d.amount));
    final reported = owedToMe.reported;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          if (payable.isPositive)
            AppButton(
              label: 'Pagar ${MoneyFormat.format(payable)}',
              icon: Icons.payments_rounded,
              onPressed: () => navigator.openPay(iOwe.teamId, iOwe.userId),
            ),
          if (reported.isNotEmpty)
            AppButton(
              label: 'Confirmar pagos',
              icon: Icons.check_rounded,
              onPressed: () => runAction(
                context,
                () => ref.read(reviewDebtsCommandProvider)(
                  actorId: ref.read(sessionUserIdProvider)!,
                  decisions: [
                    for (final d in reported)
                      (
                        debtId: d.id,
                        decision: ReviewDecision.confirm,
                        note: null,
                      ),
                  ],
                ),
                success: 'Pagos confirmados',
                describe: describeOrderError,
              ),
            ),
          if (owedToMe.payable.isNotEmpty)
            AppButton(
              label: 'Recordar',
              icon: Icons.notifications_active_rounded,
              tone: AppButtonTone.tonal,
              onPressed: () =>
                  navigator.openNotice(owedToMe.teamId, [owedToMe.userId]),
            ),
        ],
      ),
    );
  }
}
