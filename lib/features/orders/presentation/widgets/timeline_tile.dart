import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/people_provider.dart';
import '../../../../core/directory/person_label.dart';
import '../../../../core/format/date_label.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../core/time/clock_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../domain/entities/debt.dart';
import '../../domain/entities/ledger_entry.dart';
import '../text/ledger_entry_text.dart';

/// Una línea de la bitácora: quién hizo qué y cuándo.
class TimelineTile extends ConsumerWidget {
  const new({
    required this.entry,
    required this.teamId,
    required this.debts,
    super.key,
  });

  final LedgerEntry entry;
  final String teamId;

  /// Las deudas del pedido, para nombrar a quién afecta cada línea.
  final Map<String, Debt> debts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final people = ref.watch(peopleProvider).value ?? const {};
    final me = ref.watch(sessionUserIdProvider);
    String name(String userId) =>
        PersonLabel.of(people, teamId: teamId, userId: userId, me: me);
    final debtor = debts[entry.debtId]?.debtorId;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 8, color: scheme.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              LedgerEntryText.of(
                entry,
                actor: name(entry.actorId),
                debtor: debtor == null ? null : name(debtor),
              ),
              style: text.bodyMedium,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            DateLabel.ago(entry.at, now: ref.watch(clockProvider)()),
            style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
