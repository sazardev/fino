import '../../../core/money/money.dart';

/// A quién se le puede avisar y cuánto le debe al remitente.
abstract interface class NoticeAudience {
  Future<Set<String>> memberIds(String teamId);

  /// Quienes le deben algo vivo a [senderId] en el equipo, con el total que
  /// cada uno debe (SPEC A1, A4). Sirve también para "avisar a todos los que
  /// me deben".
  Future<Map<String, Money>> owedTo(String senderId, String teamId);
}
