import '../team_store.dart';
import '../use_cases/transfer_admin.dart';

/// El admin pasa su rol a otro miembro (SPEC E6).
class TransferAdminCommand {
  const new(this._store);

  final TeamStore _store;

  Future<void> call({
    required String actorId,
    required String teamId,
    required String targetUserId,
  }) async {
    final change = const TransferAdmin()(
      actorId: actorId,
      targetUserId: targetUserId,
      roster: await _store.rosterOf(teamId),
    );
    await _store.apply(change, actorId: actorId);
  }
}
