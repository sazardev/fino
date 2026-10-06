import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/money/money.dart';
import '../../../../core/time/clock_provider.dart';
import 'order_draft.dart';

part 'order_draft_controller.g.dart';

/// El formulario de "Nuevo pedido": cada cambio recalcula el reparto en vivo
/// (`draftSplitProvider`).
@riverpod
class OrderDraftController extends _$OrderDraftController {
  @override
  OrderDraft build() => OrderDraft(spentAt: ref.read(clockProvider)());

  /// Cambiar de equipo vacía a los deudores: eran de otro equipo.
  void selectTeam(String teamId) {
    if (state.teamId == teamId) return;
    state = state.copyWith(teamId: teamId, participants: [], fixed: {});
  }

  void setConcept(String concept) => state = state.copyWith(concept: concept);

  void setTotal(Money? total) => state = state.copyWith(total: total);

  void setNote(String note) => state = state.copyWith(note: note);

  void setSpentAt(DateTime date) => state = state.copyWith(spentAt: date);

  void toggleCreditorIncluded() =>
      state = state.copyWith(creditorIncluded: !state.creditorIncluded);

  void toggleParticipant(String userId) {
    final participants = [...state.participants];
    final fixed = {...state.fixed};
    if (!participants.remove(userId)) {
      participants.add(userId);
    } else {
      fixed.remove(userId);
    }
    state = state.copyWith(participants: participants, fixed: fixed);
  }

  /// Fija el monto de alguien; `null` lo devuelve al reparto automático.
  void setFixed(String userId, Money? amount) {
    final fixed = {...state.fixed};
    amount == null ? fixed.remove(userId) : fixed[userId] = amount;
    state = state.copyWith(fixed: fixed);
  }
}
