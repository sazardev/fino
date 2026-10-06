import '../../../../core/money/money.dart';
import 'person_balance.dart';

/// Lo que muestra Inicio: totales y, por persona, qué debo y qué me deben.
final class BalanceView {
  const new({required this.iOwe, required this.owedToMe});

  final List<PersonBalance> iOwe;
  final List<PersonBalance> owedToMe;

  Money get totalIOwe => Money.sum(iOwe.map((b) => b.total));

  Money get totalOwedToMe => Money.sum(owedToMe.map((b) => b.total));

  /// Pagos que me reportaron y esperan mi confirmación (acción pendiente).
  List<PersonBalance> get toConfirm =>
      owedToMe.where((b) => b.reported.isNotEmpty).toList();

  bool get isEmpty => iOwe.isEmpty && owedToMe.isEmpty;
}
