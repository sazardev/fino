// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Inicio agrupado por persona *y equipo* (pagar es por equipo, M1), el
/// monto mayor primero. No compensa deudas cruzadas (SPEC §6.7).

@ProviderFor(balanceView)
final balanceViewProvider = BalanceViewProvider._();

/// Inicio agrupado por persona *y equipo* (pagar es por equipo, M1), el
/// monto mayor primero. No compensa deudas cruzadas (SPEC §6.7).

final class BalanceViewProvider
    extends
        $FunctionalProvider<
          AsyncValue<BalanceView>,
          BalanceView,
          FutureOr<BalanceView>
        >
    with $FutureModifier<BalanceView>, $FutureProvider<BalanceView> {
  /// Inicio agrupado por persona *y equipo* (pagar es por equipo, M1), el
  /// monto mayor primero. No compensa deudas cruzadas (SPEC §6.7).
  BalanceViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'balanceViewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$balanceViewHash();

  @$internal
  @override
  $FutureProviderElement<BalanceView> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BalanceView> create(Ref ref) {
    return balanceView(ref);
  }
}

String _$balanceViewHash() => r'3a13474edf54385d7722a442fbc877926d2b8d2c';
