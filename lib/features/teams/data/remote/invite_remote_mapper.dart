import '../../../../core/database/outbox_operation.dart';
import '../../../../core/sync/remote_write.dart';

/// El código de invitación como documento: `invites/{CODE}` (SPEC E2–E3).
abstract final class InviteRemoteMapper {
  static const collection = 'invites';

  static RemoteWrite create({
    required String code,
    required String teamId,
    required String teamName,
  }) => RemoteWrite(
    collection: collection,
    id: code,
    operation: OutboxOperation.create,
    fields: {'teamId': teamId, 'teamName': teamName},
  );

  static RemoteWrite delete(String code) => RemoteWrite(
    collection: collection,
    id: code,
    operation: OutboxOperation.delete,
  );
}
