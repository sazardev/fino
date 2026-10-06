import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../domain/failures/order_failure.dart';
import '../../domain/failures/order_failure_reason.dart';
import '../../domain/split/split_calculator.dart';
import '../../domain/split/split_entry.dart';
import 'draft_split.dart';
import 'order_draft_controller.dart';

part 'draft_split_provider.g.dart';

/// El reparto del pedido en captura, calculado con las mismas reglas que
/// usará al guardarse (SPEC §5.2): lo que se ve es lo que se guarda.
@riverpod
DraftSplit draftSplit(Ref ref) {
  final draft = ref.watch(orderDraftControllerProvider);
  final total = draft.total;
  if (total == null) {
    return const DraftSplit(problem: OrderFailureReason.totalNotPositive);
  }
  if (draft.participants.isEmpty) {
    return const DraftSplit(problem: OrderFailureReason.noDebtors);
  }
  try {
    final split = const SplitCalculator().calculate(
      total: total,
      creditorId: ref.watch(sessionUserIdProvider) ?? '',
      creditorIncluded: draft.creditorIncluded,
      entries: [
        for (final id in draft.participants)
          SplitEntry(id, fixedAmount: draft.fixed[id]),
      ],
    );
    return DraftSplit(
      amounts: split.amountByDebtor,
      creditorShare: split.creditorShare,
    );
  } on OrderFailure catch (failure) {
    return DraftSplit(problem: failure.reason);
  }
}
