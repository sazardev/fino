/// El texto de cada plantilla de aviso (SPEC A2), por su clave.
abstract final class NoticeTemplateText {
  static const askIfPaid = 'askIfPaid';
  static const holdPayments = 'holdPayments';
  static const pendingConfirmation = 'pendingConfirmation';

  static String of(String key) => switch (key) {
    askIfPaid => '¿Ya me pagaste?',
    holdPayments => 'Ya pagué, no me paguen aún',
    pendingConfirmation => 'Me falta confirmar tu pago',
    _ => key,
  };
}
