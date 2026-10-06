import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/debt.dart';
import 'balance_view.dart';
import 'debt_book_provider.dart';
import 'person_balance.dart';

part 'balance_view_provider.g.dart';

/// Inicio agrupado por persona *y equipo* (pagar es por equipo, M1), el
/// monto mayor primero. No compensa deudas cruzadas (SPEC §6.7).
@riverpod
Future<BalanceView> balanceView(Ref ref) async {
  final book = await ref.watch(debtBookProvider.future);
  return BalanceView(
    iOwe: _group([for (final g in book.iOwe) ...g.debts], (d) => d.creditorId),
    owedToMe: _group([
      for (final g in book.owedToMe) ...g.debts,
    ], (d) => d.debtorId),
  );
}

List<PersonBalance> _group(List<Debt> debts, String Function(Debt) person) {
  final byKey = <String, List<Debt>>{};
  for (final debt in debts) {
    byKey.putIfAbsent('${debt.teamId}/${person(debt)}', () => []).add(debt);
  }
  final balances = [
    for (final list in byKey.values)
      PersonBalance(
        teamId: list.first.teamId,
        userId: person(list.first),
        debts: list,
      ),
  ]..sort((a, b) => b.total.compareTo(a.total));
  return balances;
}
