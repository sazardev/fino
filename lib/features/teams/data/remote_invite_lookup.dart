import '../../../core/sync/remote_gateway.dart';
import '../domain/entities/invite_info.dart';
import '../domain/invite_lookup.dart';
import 'remote/invite_remote_mapper.dart';

/// Busca el código en Firestore: `invites/{CODE}` (solo se lee por id).
class RemoteInviteLookup implements InviteLookup {
  const new(this._gateway);

  final RemoteGateway _gateway;

  @override
  Future<InviteInfo?> find(String code) async {
    final doc = await _gateway.get('${InviteRemoteMapper.collection}/$code');
    if (doc == null) return null;
    return InviteInfo(
      teamId: doc.fields['teamId']! as String,
      teamName: (doc.fields['teamName'] as String?) ?? '',
    );
  }
}
