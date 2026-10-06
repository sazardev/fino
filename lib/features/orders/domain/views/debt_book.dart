import '../../../../core/money/money.dart';
import '../entities/debt.dart';
import 'debt_group.dart';

/// Las listas Debo y Me deben de un usuario (SPEC §7.2).
///
/// Solo cuenta deudas vivas: una deuda confirmada o cancelada pasa al
/// historial y no aparece aquí. No compensa deudas cruzadas (§6.7).
final class DebtBook {
  new(this.userId, Iterable<Debt> debts)
    : _live = debts.where((debt) => debt.status.isLive).toList();

  final String userId;
  final List<Debt> _live;

  /// Lo que debo, agrupado por acreedor.
  List<DebtGroup> get iOwe => _group(
    _live.where((debt) => debt.debtorId == userId),
    (debt) => debt.creditorId,
  );

  /// Lo que me deben, agrupado por deudor.
  List<DebtGroup> get owedToMe => _group(
    _live.where((debt) => debt.creditorId == userId),
    (debt) => debt.debtorId,
  );

  Money get totalIOwe => Money.sum(iOwe.map((group) => group.total));

  Money get totalOwedToMe => Money.sum(owedToMe.map((group) => group.total));

  List<DebtGroup> _group(
    Iterable<Debt> debts,
    String Function(Debt) counterparty,
  ) {
    final byPerson = <String, List<Debt>>{};
    for (final debt in debts) {
      byPerson.putIfAbsent(counterparty(debt), () => []).add(debt);
    }
    return [
      for (final MapEntry(key: id, value: list) in byPerson.entries)
        DebtGroup(id, list),
    ];
  }
}
