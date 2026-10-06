import 'package:freezed_annotation/freezed_annotation.dart';

/// Un destinatario omitido por límite de frecuencia, y cuándo podrá
/// recibir otro aviso (SPEC A3).
@immutable
final class SkippedRecipient {
  const new(this.userId, this.retryAt);

  final String userId;
  final DateTime retryAt;

  @override
  bool operator ==(Object other) =>
      other is SkippedRecipient &&
      other.userId == userId &&
      other.retryAt == retryAt;

  @override
  int get hashCode => Object.hash(userId, retryAt);
}
