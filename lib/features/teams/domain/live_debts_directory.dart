import 'entities/live_debts.dart';

/// Cuántas deudas vivas hay: lo que bloquea salir, expulsar o eliminar
/// (SPEC §4.2). Lo responde la capa de pedidos.
abstract interface class LiveDebtsDirectory {
  Future<LiveDebts> ofUser(String userId, String teamId);

  Future<LiveDebts> ofTeam(String teamId);
}
