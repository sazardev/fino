import 'entities/payout_snapshot.dart';

/// Lo que pedidos necesita saber del equipo (quién es miembro, a dónde le
/// pagan a alguien) sin conocer cómo se guarda.
abstract interface class TeamDirectory {
  Future<Set<String>> memberIds(String teamId);

  /// Banco y últimos 4 dígitos del método de cobro de [userId] si este
  /// dispositivo puede verlo (SPEC M4); `null` si no tiene o no se ve.
  Future<PayoutSnapshot?> payoutOf(String teamId, String userId);
}
