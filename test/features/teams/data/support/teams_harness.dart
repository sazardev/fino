import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/features/teams/data/local_live_debts_directory.dart';
import 'package:fino/features/teams/data/local_team_store.dart';
import 'package:fino/features/teams/domain/commands/create_team_command.dart';
import 'package:fino/features/teams/domain/commands/delete_team_command.dart';
import 'package:fino/features/teams/domain/commands/expel_member_command.dart';
import 'package:fino/features/teams/domain/commands/join_team_command.dart';
import 'package:fino/features/teams/domain/commands/leave_team_command.dart';
import 'package:fino/features/teams/domain/commands/refresh_member_profile_command.dart';
import 'package:fino/features/teams/domain/commands/regenerate_invite_code_command.dart';
import 'package:fino/features/teams/domain/commands/set_payout_method_command.dart';
import 'package:fino/features/teams/domain/commands/transfer_admin_command.dart';
import 'package:fino/features/teams/domain/entities/invite_info.dart';
import 'package:fino/features/teams/domain/invite_lookup.dart';

/// Un invite lookup de mentira: un mapa código → equipo.
class FakeInviteLookup implements InviteLookup {
  final invites = <String, InviteInfo>{};

  @override
  Future<InviteInfo?> find(String code) async => invites[code];
}

/// Un dispositivo de mentira para equipos: base en memoria + store + comandos.
class TeamsHarness {
  new()
    : db = AppDatabase(NativeDatabase.memory()),
      invites = FakeInviteLookup() {
    store = LocalTeamStore(db, _newId, () => now);
    debts = LocalLiveDebtsDirectory(db);
  }

  final AppDatabase db;
  final FakeInviteLookup invites;
  late final LocalTeamStore store;
  late final LocalLiveDebtsDirectory debts;
  DateTime now = DateTime.utc(2026, 10, 6, 12);
  var _n = 0;
  var _codes = 0;

  String _newId() => 'id${++_n}';
  String _newCode() => 'CODE${(++_codes).toString().padLeft(4, '0')}';

  CreateTeamCommand get createTeam =>
      CreateTeamCommand(store, _newId, _newCode, () => now);
  JoinTeamCommand get joinTeam => JoinTeamCommand(store, invites, () => now);
  RegenerateInviteCodeCommand get regenerateCode =>
      RegenerateInviteCodeCommand(store, _newCode);
  TransferAdminCommand get transferAdmin => TransferAdminCommand(store);
  LeaveTeamCommand get leaveTeam => LeaveTeamCommand(store, debts);
  ExpelMemberCommand get expelMember => ExpelMemberCommand(store, debts);
  DeleteTeamCommand get deleteTeam => DeleteTeamCommand(store, debts);
  SetPayoutMethodCommand get setPayoutMethod => SetPayoutMethodCommand(store);
  RefreshMemberProfileCommand get refreshProfile =>
      RefreshMemberProfileCommand(store);

  Future<List<List<RemoteWrite>>> batches() async {
    final entries = await db.select(db.outboxEntries).get();
    final ids = <String>[];
    for (final entry in entries) {
      if (!ids.contains(entry.batchId)) ids.add(entry.batchId);
    }
    return [for (final id in ids) await db.outboxDao.writesOfBatch(id)];
  }

  Future<void> close() => db.close();
}
