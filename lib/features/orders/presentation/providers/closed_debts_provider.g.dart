// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'closed_debts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Historial: deudas confirmadas o canceladas donde soy parte.

@ProviderFor(closedDebts)
final closedDebtsProvider = ClosedDebtsProvider._();

/// Historial: deudas confirmadas o canceladas donde soy parte.

final class ClosedDebtsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Debt>>,
          List<Debt>,
          Stream<List<Debt>>
        >
    with $FutureModifier<List<Debt>>, $StreamProvider<List<Debt>> {
  /// Historial: deudas confirmadas o canceladas donde soy parte.
  ClosedDebtsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'closedDebtsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$closedDebtsHash();

  @$internal
  @override
  $StreamProviderElement<List<Debt>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Debt>> create(Ref ref) {
    return closedDebts(ref);
  }
}

String _$closedDebtsHash() => r'db9292737cd71a0b9dfc10fc1518c09c282ba454';
