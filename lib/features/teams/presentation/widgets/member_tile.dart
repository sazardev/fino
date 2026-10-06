import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_durations.dart';
import '../../../../ui/molecules/person_tile.dart';
import '../../../../ui/molecules/status_pill.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/enums/team_role.dart';
import 'member_admin_actions.dart';

/// Alguien del equipo. Si soy admin, tocarlo despliega lo que puedo hacer:
/// pasarle el rol o expulsarlo (SPEC E5, E6, §4.2).
class MemberTile extends ConsumerStatefulWidget {
  const new({required this.member, required this.iAmAdmin, super.key});

  final TeamMember member;
  final bool iAmAdmin;

  @override
  ConsumerState<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends ConsumerState<MemberTile> {
  var _open = false;

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(sessionUserIdProvider);
    final member = widget.member;
    final isMe = member.userId == me;
    final admin = member.role == TeamRole.admin;
    final canManage = widget.iAmAdmin && !isMe;

    return AnimatedSize(
      duration: AppDurations.medium,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PersonTile(
            name: isMe ? '${member.displayName} (tú)' : member.displayName,
            seed: member.userId,
            photoUrl: member.photoUrl,
            trailing: StatusPill(admin ? 'Admin' : 'Miembro', strong: admin),
            onTap: canManage ? () => setState(() => _open = !_open) : null,
          ),
          if (_open && canManage) MemberAdminActions(member: member),
        ],
      ),
    );
  }
}
