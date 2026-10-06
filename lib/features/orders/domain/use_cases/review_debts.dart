import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/debt.dart';
import '../entities/ledger_entry.dart';
import '../entities/order.dart';
import '../entities/order_change_set.dart';
import '../enums/debt_status.dart';
import '../enums/ledger_event_type.dart';
import '../enums/review_decision.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import 'debt_concepts.dart';
import 'debt_review.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';
import 'order_text.dart';

/// El acreedor confirma o rechaza pagos reportados, de golpe o uno por uno
/// (SPEC §6.2, G5). Cada deudor recibe un solo resumen (G6).
class ReviewDebts {
  const new(this._newId);

  final IdGenerator _newId;

  /// Repetir la misma decisión (doble tap) no cambia nada ni notifica.
  OrderChangeSet call({
    required String actorId,
    required List<DebtReview> reviews,
    required Map<String, Order> orders,
    required DateTime now,
  }) {
    if (reviews.isEmpty) {
      throw const OrderFailure(OrderFailureReason.emptySelection);
    }
    final recorder = LedgerRecorder(_newId);
    final debts = <Debt>[];
    final ledger = <LedgerEntry>[];
    final outcomes = <String, _DebtorOutcome>{};

    for (final review in reviews) {
      final debt = review.debt;
      OrderGuards.requireCreditor(actorId, debt.creditorId);
      final next = _apply(review, now);
      if (next == null) continue;
      debts.add(next);
      outcomes
          .putIfAbsent(debt.debtorId, _DebtorOutcome.new)
          .add(review, orders);
      ledger.add(
        recorder.record(
          orderId: debt.orderId,
          type: review.decision == ReviewDecision.confirm
              ? LedgerEventType.paymentConfirmed
              : LedgerEventType.paymentRejected,
          actorId: actorId,
          at: now,
          debtId: debt.id,
          paymentId: debt.paymentId,
          note: OrderText.reason(review.note),
        ),
      );
    }
    if (debts.isEmpty) return OrderChangeSet.empty;

    return OrderChangeSet(
      debts: debts,
      ledger: ledger,
      notifications: [
        for (final MapEntry(key: debtorId, value: outcome) in outcomes.entries)
          outcome.toIntent(actorId, debtorId, debts.first.teamId),
      ],
    );
  }

  Debt? _apply(DebtReview review, DateTime now) {
    final debt = review.debt;
    switch (review.decision) {
      case ReviewDecision.confirm:
        if (debt.status == DebtStatus.confirmed) return null;
        _requireReported(debt);
        return debt.copyWith(status: DebtStatus.confirmed, updatedAt: now);
      case ReviewDecision.reject:
        if (debt.status == DebtStatus.pending) return null;
        _requireReported(debt);
        return debt.copyWith(
          status: DebtStatus.pending,
          paymentId: null,
          updatedAt: now,
        );
    }
  }

  void _requireReported(Debt debt) {
    if (debt.status != DebtStatus.paymentReported) {
      throw const OrderFailure(OrderFailureReason.invalidTransition);
    }
  }
}

/// Acumula lo que se decidió sobre las deudas de un mismo deudor.
class _DebtorOutcome {
  final _confirmed = <Debt>[];
  var _rejected = 0;
  String? _note;
  String? _paymentId;
  String? _debtId;
  String? _concept;

  void add(DebtReview review, Map<String, Order> orders) {
    final debt = review.debt;
    _paymentId ??= debt.paymentId;
    _debtId ??= debt.id;
    _concept ??= DebtConcepts.lead([debt], orders);
    if (review.decision == ReviewDecision.confirm) {
      _confirmed.add(debt);
    } else {
      _rejected++;
      _note ??= OrderText.reason(review.note);
    }
  }

  NotificationIntent toIntent(String actorId, String debtorId, String teamId) {
    final paymentId = _paymentId;
    return NotificationIntent(
      kind: NotificationKind.paymentReviewed,
      recipientId: debtorId,
      actorId: actorId,
      teamId: teamId,
      target: paymentId != null
          ? NotificationTarget.payment(paymentId)
          : NotificationTarget.debt(_debtId!),
      amount: Money.sum(_confirmed.map((debt) => debt.amount)),
      concept: _concept,
      debtCount: _confirmed.length,
      rejectedCount: _rejected,
      note: _note,
    );
  }
}
