// coverage:ignore-file
// Pure delegation to the google_sign_in plugin; nothing to test without a
// device.
import 'package:google_sign_in/google_sign_in.dart';

import 'google_account_gateway.dart';

class PluginGoogleAccountGateway implements GoogleAccountGateway {
  new({required this.serverClientId});

  final String serverClientId;

  // `initialize` must run exactly once, before the first `authenticate`.
  late final Future<void> _ready = GoogleSignIn.instance.initialize(
    serverClientId: serverClientId,
  );

  @override
  Future<String?> authenticate() async {
    await _ready;
    final account = await GoogleSignIn.instance.authenticate();
    return account.authentication.idToken;
  }

  @override
  Future<void> signOut() async {
    await _ready;
    await GoogleSignIn.instance.signOut();
  }
}
