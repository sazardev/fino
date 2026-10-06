import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../flavor/flavor_config_provider.dart';
import 'app_logger.dart';

part 'app_logger_provider.g.dart';

@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) =>
    AppLogger(verbose: ref.watch(flavorConfigProvider).verboseLogging);
