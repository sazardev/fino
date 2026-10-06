import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pay_selection_controller.g.dart';

/// Qué deudas quedaron fuera del pago que se está armando (SPEC §6.3). Se
/// guarda lo excluido: una deuda que llega mientras tanto entra sola.
@riverpod
class PaySelectionController extends _$PaySelectionController {
  @override
  Set<String> build(String teamId, String creditorId) => const {};

  void toggle(String debtId) {
    final excluded = {...state};
    if (!excluded.remove(debtId)) excluded.add(debtId);
    state = excluded;
  }
}
