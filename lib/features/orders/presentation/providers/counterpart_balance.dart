import 'person_balance.dart';

/// Lo vivo con una persona en un equipo, en ambos sentidos.
final class CounterpartBalance {
  const new({required this.iOwe, required this.owedToMe});

  final PersonBalance iOwe;
  final PersonBalance owedToMe;

  bool get isEmpty => iOwe.debts.isEmpty && owedToMe.debts.isEmpty;
}
