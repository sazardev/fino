import 'package:flutter/widgets.dart';

import 'app/fino_app.dart';
import 'app/settings/app_settings.dart';
import 'core/haptics/haptics_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = await AppSettings.load();
  bindHaptics(settings.hapticsEnabled);

  runApp(FinoApp(settings: settings));
}
