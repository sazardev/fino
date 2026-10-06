import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'inbox_navigator.dart';

part 'inbox_navigator_provider.g.dart';

/// Lo sobrescribe la app con su router (`appProviderOverrides`).
@Riverpod(keepAlive: true)
InboxNavigator inboxNavigator(Ref ref) =>
    throw UnimplementedError('InboxNavigator is provided by the app');
