import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../use_cases/retract_payment.dart';
import 'order_loader.dart';

/// El deudor retira su "Ya pagué", completo o solo algunas deudas.
class RetractPaymentCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  /// Sin [debtIds] retira todas las deudas del pago.
  Future<void> call({
    required String actorId,
    required String paymentId,
    List<String>? debtIds,
  }) async {
    final loader = OrderLoader(_repo);
    final payment = await loader.payment(paymentId);
    final debts = debtIds == null
        ? await _repo.debtsOfPayment(paymentId)
        : await loader.debts(debtIds);
    final changes = RetractPayment(_newId)(
      actorId: actorId,
      payment: payment,
      debts: debts,
      orders: await _repo.findOrders({for (final d in debts) d.orderId}),
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: payment.teamId);
  }
}
