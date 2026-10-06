import '../../../../core/database/app_database.dart';
import '../../../../core/sync/remote_document.dart';
import '../mappers/payout_method_mapper.dart';
import '../remote/payout_method_remote_mapper.dart';

/// `teams/{team}/members/{uid}/payout/main` → Drift.
class PayoutDocumentApplier {
  const new(this._db, this.teamId, this.userId);

  final AppDatabase _db;
  final String teamId;
  final String userId;

  String get path =>
      '${PayoutMethodRemoteMapper.collection(teamId, userId)}/'
      '${PayoutMethodRemoteMapper.documentId}';

  /// [document] `null` = ya no se puede ver (o no existe): se quita. No pisa
  /// lo que tiene escrituras pendientes.
  Future<void> apply(RemoteDocument? document) => _db.transaction(() async {
    if ((await _db.outboxDao.pendingPaths()).contains(path)) return;
    if (document == null) {
      await _db.teamsDao.removePayoutMethod(teamId, userId);
      return;
    }
    await _db.teamsDao.upsertPayoutMethod(
      PayoutMethodMapper.toCompanion(
        PayoutMethodRemoteMapper.fromFields(document.fields),
        teamId: teamId,
        userId: userId,
      ),
    );
  });
}
