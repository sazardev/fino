// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counterpart_balance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Lo que le debo a una persona y lo que me debe, en un equipo.

@ProviderFor(counterpartBalance)
final counterpartBalanceProvider = CounterpartBalanceFamily._();

/// Lo que le debo a una persona y lo que me debe, en un equipo.

final class CounterpartBalanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<CounterpartBalance>,
          CounterpartBalance,
          FutureOr<CounterpartBalance>
        >
    with
        $FutureModifier<CounterpartBalance>,
        $FutureProvider<CounterpartBalance> {
  /// Lo que le debo a una persona y lo que me debe, en un equipo.
  CounterpartBalanceProvider._({
    required CounterpartBalanceFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'counterpartBalanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$counterpartBalanceHash();

  @override
  String toString() {
    return r'counterpartBalanceProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<CounterpartBalance> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CounterpartBalance> create(Ref ref) {
    final argument = this.argument as (String, String);
    return counterpartBalance(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is CounterpartBalanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$counterpartBalanceHash() =>
    r'44ab609cc5e060b9b41aa438e666e9f450be12d8';

/// Lo que le debo a una persona y lo que me debe, en un equipo.

final class CounterpartBalanceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<CounterpartBalance>,
          (String, String)
        > {
  CounterpartBalanceFamily._()
    : super(
        retry: null,
        name: r'counterpartBalanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Lo que le debo a una persona y lo que me debe, en un equipo.

  CounterpartBalanceProvider call(String teamId, String userId) =>
      CounterpartBalanceProvider._(argument: (teamId, userId), from: this);

  @override
  String toString() => r'counterpartBalanceProvider';
}
