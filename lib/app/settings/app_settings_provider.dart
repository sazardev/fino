import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_settings.dart';

part 'app_settings_provider.g.dart';

/// The person's loaded settings; overridden once, in `bootstrap`.
@Riverpod(keepAlive: true)
AppSettings appSettings(Ref ref) =>
    throw UnimplementedError('appSettingsProvider must be overridden.');
