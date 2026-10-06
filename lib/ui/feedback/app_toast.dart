import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../design/app_radii.dart';

/// Un aviso breve y flotante al pie (no es un modal: no bloquea nada).
abstract final class AppToast {
  static void show(BuildContext context, String message, {bool error = false}) {
    final scheme = Theme.of(context).colorScheme;
    error ? Haptics.warning() : Haptics.success();
    ScaffoldMessenger.maybeOf(context)
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: error ? scheme.onErrorContainer : scheme.onInverseSurface,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: error
              ? scheme.errorContainer
              : scheme.inverseSurface,
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.mdRadius),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
