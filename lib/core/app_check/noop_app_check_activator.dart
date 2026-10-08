import 'app_check_activator.dart';

/// Where App Check does not exist (Linux, web): does nothing.
class NoopAppCheckActivator implements AppCheckActivator {
  const new();

  @override
  Future<void> activate() async {}
}
