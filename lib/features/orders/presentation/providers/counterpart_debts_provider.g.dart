// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counterpart_debts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mis deudas vivas con una persona en un equipo, en ambos sentidos.

@ProviderFor(counterpartDebts)
final counterpartDebtsProvider = CounterpartDebtsFamily._();

/// Mis deudas vivas con una persona en un equipo, en ambos sentidos.

final class CounterpartDebtsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Debt>>,
          List<Debt>,
          FutureOr<List<Debt>>
        >
    with $FutureModifier<List<Debt>>, $FutureProvider<List<Debt>> {
  /// Mis deudas vivas con una persona en un equipo, en ambos sentidos.
  CounterpartDebtsProvider._({
    required CounterpartDebtsFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'counterpartDebtsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$counterpartDebtsHash();

  @override
  String toString() {
    return r'counterpartDebtsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Debt>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Debt>> create(Ref ref) {
    final argument = this.argument as (String, String);
    return counterpartDebts(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is CounterpartDebtsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$counterpartDebtsHash() => r'7407780a2c7af79f6af89738ddab541dbb5f0dfd';

/// Mis deudas vivas con una persona en un equipo, en ambos sentidos.

final class CounterpartDebtsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Debt>>, (String, String)> {
  CounterpartDebtsFamily._()
    : super(
        retry: null,
        name: r'counterpartDebtsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Mis deudas vivas con una persona en un equipo, en ambos sentidos.

  CounterpartDebtsProvider call(String teamId, String userId) =>
      CounterpartDebtsProvider._(argument: (teamId, userId), from: this);

  @override
  String toString() => r'counterpartDebtsProvider';
}
