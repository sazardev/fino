import 'package:flutter_riverpod/misc.dart';

import 'navigation/navigation_overrides.dart';
import 'session/session_overrides.dart';

/// Lo que la app conecta entre features al arrancar (la sesión y la
/// navegación). Lo usan `bootstrap` y las pruebas por igual.
List<Override> appProviderOverrides() => [
  ...sessionOverrides(),
  ...navigationOverrides(),
];
