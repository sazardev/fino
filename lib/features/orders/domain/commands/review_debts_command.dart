import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../orders_repository.dart';
import '../use_cases/debt_review.dart';
import '../use_cases/review_debts.dart';
import 'debt_decision.dart';
import 'order_loader.dart';

/// El acreedor confirma o rechaza pagos reportados, de golpe o uno por uno.
class ReviewDebtsCommand {
  const new(this._repo, this._newId, this._clock);

  final OrdersRepository _repo;
  final IdGenerator _newId;
  final Clock _clock;

  Future<void> call({
    required String actorId,
    required List<DebtDecision> decisions,
  }) async {
    final debts = await OrderLoader(_repo)
        .debts([for (final d in decisions) d.debtId]);
    final changes = ReviewDebts(_newId)(
      actorId: actorId,
      reviews: [
        for (final (i, debt) in debts.indexed)
          DebtReview(debt, decisions[i].decision, note: decisions[i].note),
      ],
      orders: await _repo.findOrders({for (final d in debts) d.orderId}),
      now: _clock(),
    );
    await _repo.apply(changes, actorId: actorId, teamId: debts.first.teamId);
  }
}
