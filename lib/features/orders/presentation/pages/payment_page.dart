import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/money.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/molecules/settings_row.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../../domain/enums/debt_status.dart';
import '../providers/payment_debts_provider.dart';
import '../providers/payment_provider.dart';
import '../widgets/counterpart_debt_line.dart';
import '../widgets/payment_headline.dart';
import '../widgets/payment_review_actions.dart';

/// Un pago agrupado (SPEC §6.3): qué cubre, a qué cuenta se hizo y qué falta
/// resolver. Aquí llevan los avisos de pago del buzón.
class PaymentPage extends ConsumerWidget {
  const new({required this.paymentId, super.key, this.onBack});

  final String paymentId;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(sessionUserIdProvider);
    final payment = ref.watch(paymentProvider(paymentId));
    final debts = ref.watch(paymentDebtsProvider(paymentId));
    final found = payment.value;
    final list = debts.value ?? const [];
    final reported = [
      for (final d in list)
        if (d.status == DebtStatus.paymentReported) d,
    ];

    return SettingsShell(
      title: 'Pago',
      onBack: onBack,
      loaded: payment.hasValue && debts.hasValue,
      children: [
        if (found == null || list.isEmpty)
          const EmptyState(
            icon: Icons.task_alt_rounded,
            title: 'Este pago ya se resolvió',
            hint: 'Lo que cubría ya se confirmó, se rechazó o se retiró.',
          )
        else ...[
          PaymentHeadline(
            payment: found,
            total: Money.sum(list.map((d) => d.amount)),
          ),
          SettingsRow(
            label: 'A la cuenta',
            subtitle: [
              ?found.payoutShown.bankName,
              '···${found.payoutShown.last4}',
            ].join(' '),
            trailing: const Icon(Icons.account_balance_rounded),
          ),
          if (found.reference case final reference?)
            SettingsRow(
              label: 'Referencia',
              subtitle: reference,
              trailing: const Icon(Icons.tag_rounded),
            ),
          const SectionHeader('Lo que cubre'),
          for (final debt in list)
            CounterpartDebtLine(debt: debt, iAmCreditor: me == debt.creditorId),
          PaymentReviewActions(payment: found, reported: reported),
        ],
      ],
    );
  }
}
