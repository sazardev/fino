import 'package:fino/features/teams/domain/entities/invite_info.dart';
import 'package:fino/features/teams/domain/invite_lookup.dart';

/// Códigos de invitación sin servidor.
class FakeInviteLookup implements InviteLookup {
  new([this.invites = const {}]);

  final Map<String, InviteInfo> invites;

  @override
  Future<InviteInfo?> find(String code) async => invites[code];
}
