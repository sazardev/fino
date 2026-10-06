import 'package:flutter/widgets.dart';

import 'app_toast.dart';

/// Corre una acción del usuario y le cuenta cómo salió: [success] si salió
/// bien; si falló, lo que diga [describe] (o un mensaje genérico). Devuelve si
/// salió bien.
Future<bool> runAction(
  BuildContext context,
  Future<void> Function() action, {
  String? success,
  String? Function(Object error)? describe,
}) async {
  try {
    await action();
    if (success != null && context.mounted) AppToast.show(context, success);
    return true;
  } on Object catch (error) {
    if (context.mounted) {
      AppToast.show(
        context,
        describe?.call(error) ?? 'No se pudo completar. Intenta de nuevo.',
        error: true,
      );
    }
    return false;
  }
}
