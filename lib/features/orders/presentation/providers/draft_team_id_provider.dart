import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/directory/my_teams_provider.dart';
import 'order_draft_controller.dart';

part 'draft_team_id_provider.g.dart';

/// El equipo del pedido en captura: el elegido o, si no se ha elegido, el
/// primero (con un solo equipo no hay nada que elegir).
@riverpod
String? draftTeamId(Ref ref) {
  final chosen = ref.watch(orderDraftControllerProvider).teamId;
  if (chosen != null) return chosen;
  return ref.watch(myTeamsProvider).value?.firstOrNull?.id;
}
