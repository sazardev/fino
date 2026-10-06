import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'clock.dart';

part 'clock_provider.g.dart';

/// La hora actual (UTC). Se sobrescribe en pruebas.
@Riverpod(keepAlive: true)
Clock clock(Ref ref) =>
    () => DateTime.now().toUtc();
