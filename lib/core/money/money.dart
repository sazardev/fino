import 'package:freezed_annotation/freezed_annotation.dart';

/// Pesos mexicanos como centavos enteros (nunca decimales flotantes).
@immutable
final class Money implements Comparable<Money> {
  const new(this.cents);

  static const zero = Money(0);

  final int cents;

  bool get isPositive => cents > 0;

  bool get isZero => cents == 0;

  bool get isNegative => cents < 0;

  Money operator +(Money other) => Money(cents + other.cents);

  Money operator -(Money other) => Money(cents - other.cents);

  Money operator *(int times) => Money(cents * times);

  bool operator <(Money other) => cents < other.cents;

  bool operator <=(Money other) => cents <= other.cents;

  bool operator >(Money other) => cents > other.cents;

  bool operator >=(Money other) => cents >= other.cents;

  /// Suma de [values]; [zero] si está vacío.
  static Money sum(Iterable<Money> values) =>
      values.fold(zero, (total, value) => total + value);

  @override
  int compareTo(Money other) => cents.compareTo(other.cents);

  @override
  bool operator ==(Object other) => other is Money && other.cents == cents;

  @override
  int get hashCode => cents.hashCode;

  @override
  String toString() => 'Money($cents)';
}
