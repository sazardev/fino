import '../entities/debt.dart';
import '../enums/review_decision.dart';

/// La decisión del acreedor sobre una deuda con pago reportado.
final class DebtReview {
  const new(this.debt, this.decision, {this.note});

  final Debt debt;
  final ReviewDecision decision;

  /// Motivo opcional (útil al rechazar).
  final String? note;
}
