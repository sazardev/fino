import '../../../../core/sync/pull/scoped_collection_applier.dart';
import '../../../../core/sync/remote_document.dart';
import '../mappers/payment_mapper.dart';
import '../remote/payment_remote_mapper.dart';

/// `teams/{team}/payments` → Drift.
class PaymentsApplier extends ScopedCollectionApplier {
  const new(super.db, this.teamId);

  final String teamId;

  @override
  Future<void> upsert(RemoteDocument document) =>
      db.paymentsDao.upsertPayments([
        PaymentMapper.toCompanion(
          PaymentRemoteMapper.fromFields(document.id, teamId, document.fields),
        ),
      ]);

  @override
  Future<void> delete(String id) => db.paymentsDao.deletePayment(id);

  @override
  Future<Set<String>> localIds() => db.paymentsDao.idsOfTeam(teamId);

  @override
  String pathOf(String id) => '${PaymentRemoteMapper.collection(teamId)}/$id';
}
