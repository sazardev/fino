import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';

/// Normaliza y valida los textos que captura el usuario.
abstract final class OrderText {
  static const maxConceptLength = 80;
  static const maxReferenceLength = 100;
  static const maxCommentLength = 200;

  /// Concepto obligatorio y corto.
  static String concept(String raw) {
    final value = raw.trim();
    if (value.isEmpty) {
      throw const OrderFailure(OrderFailureReason.conceptRequired);
    }
    if (value.length > maxConceptLength) {
      throw const OrderFailure(OrderFailureReason.conceptTooLong);
    }
    return value;
  }

  /// Nota opcional: vacío equivale a sin nota.
  static String? note(String? raw) {
    final value = raw?.trim();
    return value == null || value.isEmpty ? null : value;
  }

  /// Referencia de pago opcional (clave de rastreo, etc.).
  static String? reference(String? raw) {
    final value = note(raw);
    if (value != null && value.length > maxReferenceLength) {
      throw const OrderFailure(OrderFailureReason.referenceTooLong);
    }
    return value;
  }

  /// Motivo opcional (rechazo, cancelación).
  static String? reason(String? raw) {
    final value = note(raw);
    if (value != null && value.length > maxCommentLength) {
      throw const OrderFailure(OrderFailureReason.commentTooLong);
    }
    return value;
  }

  /// Comentario obligatorio (objeción).
  static String comment(String? raw) {
    final value = reason(raw);
    if (value == null) {
      throw const OrderFailure(OrderFailureReason.commentRequired);
    }
    return value;
  }
}
