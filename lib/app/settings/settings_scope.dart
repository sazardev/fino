import 'package:flutter/widgets.dart';

import 'app_settings.dart';

/// Hands [AppSettings] to every screen below it. Screens listen to the
/// individual settings they care about.
class SettingsScope extends InheritedWidget {
  const SettingsScope({
    super.key,
    required this.settings,
    required super.child,
  });

  final AppSettings settings;

  static AppSettings of(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<SettingsScope>();
    assert(scope != null, 'No SettingsScope above this context');
    return scope!.settings;
  }

  @override
  bool updateShouldNotify(SettingsScope oldWidget) =>
      settings != oldWidget.settings;
}
