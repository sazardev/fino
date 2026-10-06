import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/flavor/flavor_config_provider.dart';
import '../ui/design/app_durations.dart';
import '../ui/responsive/responsive_scaler.dart';
import '../ui/responsive/ui_size_scope.dart';
import '../ui/theme/app_theme.dart';
import 'router/app_router.dart';
import 'settings/app_settings_provider.dart';
import 'settings/settings_scope.dart';
import 'splash/splash_gate.dart';

/// Root widget: wires the user's settings into the theme and the responsive
/// scale, and the router into the app.
class FinoApp extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return SettingsScope(
      settings: settings,
      child: ListenableBuilder(
        listenable: settings.appearance,
        builder: (context, _) => MaterialApp.router(
          title: ref.watch(flavorConfigProvider).appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(settings.accent.value),
          darkTheme: AppTheme.dark(settings.accent.value),
          themeMode: settings.themeMode.value,
          themeAnimationDuration: AppDurations.medium,
          themeAnimationCurve: Curves.easeOutCubic,
          routerConfig: ref.watch(appRouterProvider),
          builder: (context, child) => UiSizeScope(
            size: settings.uiSize.value,
            child: ResponsiveScaler(child: SplashGate(child: child!)),
          ),
        ),
      ),
    );
  }
}
