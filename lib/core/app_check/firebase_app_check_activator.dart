import 'package:firebase_app_check/firebase_app_check.dart';

import 'app_check_activator.dart';

class FirebaseAppCheckActivator implements AppCheckActivator {
  new(this._appCheck);

  final FirebaseAppCheck _appCheck;

  @override
  Future<void> activate() => _appCheck.activate();
}
