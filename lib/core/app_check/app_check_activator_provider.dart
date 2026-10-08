import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase/firebase_app_check_provider.dart';
import '../platform/app_check_supported.dart';
import 'app_check_activator.dart';
import 'firebase_app_check_activator.dart';
import 'noop_app_check_activator.dart';

part 'app_check_activator_provider.g.dart';

@Riverpod(keepAlive: true)
AppCheckActivator appCheckActivator(Ref ref) => appCheckSupported
    ? FirebaseAppCheckActivator(ref.watch(firebaseAppCheckProvider))
    : const NoopAppCheckActivator();
