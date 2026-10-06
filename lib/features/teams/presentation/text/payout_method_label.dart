import '../../domain/entities/clabe_payout.dart';
import '../../domain/entities/payout_method.dart';

/// "CLABE ···5671 · BBVA": cómo se resume una cuenta de cobro.
abstract final class PayoutMethodLabel {
  static String of(PayoutMethod? method) {
    if (method == null) return 'Sin configurar: nadie sabría a dónde pagarte';
    final kind = method is ClabePayout ? 'CLABE' : 'Tarjeta';
    return ['$kind ···${method.last4}', ?method.bankName].join(' · ');
  }
}
