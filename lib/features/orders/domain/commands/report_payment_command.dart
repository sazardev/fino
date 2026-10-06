import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/clock.dart';
import '../entities/payment.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import '../orders_repository.dart';
import '../team_directory.dart';
import '../use_cases/report_payment.dart';
import 'order_loader.dart';

/// "Ya pagué": el deudor avisa que pagó una o varias deudas (SPEC §6.3).
class ReportPaymentCommand {
  const new(this._repo, this._directory, this._newId, this._clock);

  final OrdersRepository _repo;
  final TeamDirectory _directory;
  final IdGenerator _newId;
  final Clock _clock;

  /// [shownAmounts] son los montos que el deudor vio al pagar.
  Future<Payment> call({
    required String actorId,
    required List<String> debtIds,
    required Map<String, Money> shownAmounts,
    String? reference,
  }) async {
    final debts = await OrderLoader(_repo).debts(debtIds);
    final first = debts.first;
    final payout = await _directory.payoutOf(first.teamId, first.creditorId);
    if (payout == null) {
      throw const OrderFailure(OrderFailureReason.creditorWithoutPayoutMethod);
    }
    final changes = ReportPayment(_newId)(
      actorId: actorId,
      debts: debts,
      shownAmounts: shownAmounts,
      orders: await _repo.findOrders({for (final d in debts) d.orderId}),
      payoutShown: payout,
      now: _clock(),
      reference: reference,
    );
    await _repo.apply(changes, actorId: actorId, teamId: first.teamId);
    return changes.payments.single;
  }
}
