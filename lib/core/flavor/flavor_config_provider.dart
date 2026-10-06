import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flavor_config.dart';

part 'flavor_config_provider.g.dart';

/// The running build's [FlavorConfig]; overridden once, in `bootstrap`.
@Riverpod(keepAlive: true)
FlavorConfig flavorConfig(Ref ref) =>
    throw UnimplementedError('flavorConfigProvider must be overridden.');
