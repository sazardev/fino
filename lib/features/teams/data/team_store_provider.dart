import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database_provider.dart';
import '../../../core/ids/id_generator_provider.dart';
import '../../../core/sync/remote_gateway_provider.dart';
import '../../../core/time/clock_provider.dart';
import '../domain/invite_lookup.dart';
import '../domain/live_debts_directory.dart';
import '../domain/team_store.dart';
import 'local_live_debts_directory.dart';
import 'local_team_store.dart';
import 'remote_invite_lookup.dart';

part 'team_store_provider.g.dart';

@Riverpod(keepAlive: true)
TeamStore teamStore(Ref ref) => LocalTeamStore(
  ref.watch(appDatabaseProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);

@Riverpod(keepAlive: true)
LiveDebtsDirectory liveDebtsDirectory(Ref ref) =>
    LocalLiveDebtsDirectory(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
InviteLookup inviteLookup(Ref ref) =>
    RemoteInviteLookup(ref.watch(remoteGatewayProvider));
