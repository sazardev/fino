import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/directory/people_provider.dart';
import '../../../../core/directory/person_label.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/atoms/person_avatar.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/amount_text.dart';
import '../../../../ui/molecules/status_pill.dart';
import '../../domain/entities/debt.dart';
import '../../domain/enums/debt_status.dart';
import '../text/debt_status_label.dart';

/// Quién debe, cuánto y en qué va. El signo depende de quién mira: + si me
/// lo deben, − si lo debo yo, neutro si no soy parte.
class OrderDebtHeader extends ConsumerWidget {
  const new({required this.debt, super.key});

  final Debt debt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(sessionUserIdProvider);
    final key = DirectoryPerson.keyOf(debt.teamId, debt.debtorId);
    final person = ref.watch(peopleProvider.select((p) => p.value?[key]));
    final name = PersonLabel.of(
      {key: ?person},
      teamId: debt.teamId,
      userId: debt.debtorId,
      me: me,
    );
    final iAmCreditor = me == debt.creditorId;
    final direction = iAmCreditor ? true : (me == debt.debtorId ? false : null);
    final closed = !debt.status.isLive;

    return Row(
      children: [
        PersonAvatar(
          name: person?.displayName ?? name,
          seed: debt.debtorId,
          photoUrl: person?.photoUrl,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xs),
              StatusPill(
                DebtStatusLabel.of(debt.status, iAmCreditor: iAmCreditor),
                strong:
                    iAmCreditor && debt.status == DebtStatus.paymentReported,
              ),
            ],
          ),
        ),
        // Shrinks before it overflows a watch.
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AmountText(
              debt.amount,
              direction: closed ? null : direction,
            ),
          ),
        ),
      ],
    );
  }
}
