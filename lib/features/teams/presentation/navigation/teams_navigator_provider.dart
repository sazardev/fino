import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'teams_navigator.dart';

part 'teams_navigator_provider.g.dart';

/// Lo sobrescribe la app con su router (`appProviderOverrides`).
@Riverpod(keepAlive: true)
TeamsNavigator teamsNavigator(Ref ref) =>
    throw UnimplementedError('TeamsNavigator is provided by the app');
