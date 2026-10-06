import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../data/team_store_provider.dart';
import '../../domain/entities/payout_method.dart';

part 'my_payout_method_provider.g.dart';

/// Mi cuenta de cobro en el equipo (SPEC M1).
@riverpod
Stream<PayoutMethod?> myPayoutMethod(Ref ref, String teamId) => ref
    .watch(teamStoreProvider)
    .watchPayoutMethod(teamId, ref.watch(sessionUserIdProvider) ?? '');
