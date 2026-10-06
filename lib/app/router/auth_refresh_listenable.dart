import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/auth_state_provider.dart';

/// Tells the router to re-run its redirects whenever the session changes.
class AuthRefreshListenable extends ChangeNotifier {
  new(Ref ref) {
    ref.listen(authStateProvider, (_, _) => notifyListeners());
  }
}
