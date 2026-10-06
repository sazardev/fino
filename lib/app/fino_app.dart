import 'package:flutter/material.dart';

import '../ui/design/app_durations.dart';
import '../ui/responsive/responsive_scaler.dart';
import '../ui/responsive/ui_size_scope.dart';
import '../ui/theme/app_theme.dart';
import 'home/home_page.dart';
import 'settings/app_settings.dart';
import 'settings/settings_scope.dart';
import 'splash/splash_screen.dart';

/// Root widget: wires the user's settings into the theme and the responsive
/// scale.
class FinoApp extends StatelessWidget {
  const FinoApp({super.key, required this.settings});

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    return SettingsScope(
      settings: settings,
      child: ListenableBuilder(
        listenable: settings.appearance,
        builder: (context, _) => MaterialApp(
          title: 'Fino',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(settings.accent.value),
          darkTheme: AppTheme.dark(settings.accent.value),
          themeMode: settings.themeMode.value,
          themeAnimationDuration: AppDurations.medium,
          themeAnimationCurve: Curves.easeOutCubic,
          builder: (context, child) => UiSizeScope(
            size: settings.uiSize.value,
            child: ResponsiveScaler(child: child!),
          ),
          home: const SplashScreen(next: HomePage()),
        ),
      ),
    );
  }
}
