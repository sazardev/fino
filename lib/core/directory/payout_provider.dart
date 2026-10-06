import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'directory_payout.dart';
import 'people_directory_provider.dart';

part 'payout_provider.g.dart';

/// El método de cobro de alguien, si se puede ver (SPEC M4).
@riverpod
Stream<DirectoryPayout?> payout(Ref ref, String teamId, String userId) =>
    ref.watch(peopleDirectoryProvider).watchPayout(teamId, userId);
