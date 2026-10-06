import '../../../../core/sync/pull/scoped_collection_applier.dart';
import '../../../../core/sync/remote_document.dart';
import '../mappers/order_mapper.dart';
import '../remote/order_remote_mapper.dart';

/// `teams/{team}/orders` → Drift.
class OrdersApplier extends ScopedCollectionApplier {
  const new(super.db, this.teamId);

  final String teamId;

  @override
  Future<void> upsert(RemoteDocument document) => db.ordersDao.upsertOrder(
    OrderMapper.toCompanion(
      OrderRemoteMapper.fromFields(document.id, teamId, document.fields),
    ),
  );

  @override
  Future<void> delete(String id) => db.ordersDao.deleteOrder(id);

  @override
  Future<Set<String>> localIds() => db.ordersDao.idsOfTeam(teamId);

  @override
  String pathOf(String id) => '${OrderRemoteMapper.collection(teamId)}/$id';
}
