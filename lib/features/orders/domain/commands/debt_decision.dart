import '../enums/review_decision.dart';

/// Lo que decide el acreedor sobre una deuda con pago reportado.
typedef DebtDecision = ({String debtId, ReviewDecision decision, String? note});
