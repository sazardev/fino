import '../../../../core/time/clock.dart';
import '../entities/debt.dart';
import '../entities/payment.dart';
import '../orders_repository.dart';
import '../use_cases/find_stale_payments.dart';

/// Avisa al acreedor de pagos reportados que llevan más de 48 h sin
/// confirmar, una sola vez por pago (SPEC #13). Se corre de forma periódica.
class RemindStalePaymentsCommand {
  const new(
    this._repo,
    this._clock, [
    this._finder = const FindStalePayments(),
  ]);

  final OrdersRepository _repo;
  final Clock _clock;
  final FindStalePayments _finder;

  Future<void> call({required String creditorId}) async {
    final payments = await _repo.paymentsToRemind(creditorId);
    for (final payment in payments) {
      final debts = await _repo.debtsOfPayment(payment.id);
      await _remind(creditorId, payment.teamId, [payment], debts);
    }
  }

  Future<void> _remind(
    String creditorId,
    String teamId,
    List<Payment> payments,
    List<Debt> debts,
  ) async {
    final changes = _finder(payments: payments, debts: debts, now: _clock());
    if (changes.isEmpty) return;
    await _repo.apply(changes, actorId: creditorId, teamId: teamId);
  }
}
