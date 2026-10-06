// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_selection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Las deudas pendientes que le debo a [creditorId] y cuáles van en el pago.

@ProviderFor(paySelection)
final paySelectionProvider = PaySelectionFamily._();

/// Las deudas pendientes que le debo a [creditorId] y cuáles van en el pago.

final class PaySelectionProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaySelection>,
          PaySelection,
          FutureOr<PaySelection>
        >
    with $FutureModifier<PaySelection>, $FutureProvider<PaySelection> {
  /// Las deudas pendientes que le debo a [creditorId] y cuáles van en el pago.
  PaySelectionProvider._({
    required PaySelectionFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'paySelectionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paySelectionHash();

  @override
  String toString() {
    return r'paySelectionProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<PaySelection> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaySelection> create(Ref ref) {
    final argument = this.argument as (String, String);
    return paySelection(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is PaySelectionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paySelectionHash() => r'e648592fd696f0fabb62651b898f3ff9191aebb2';

/// Las deudas pendientes que le debo a [creditorId] y cuáles van en el pago.

final class PaySelectionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PaySelection>, (String, String)> {
  PaySelectionFamily._()
    : super(
        retry: null,
        name: r'paySelectionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Las deudas pendientes que le debo a [creditorId] y cuáles van en el pago.

  PaySelectionProvider call(String teamId, String creditorId) =>
      PaySelectionProvider._(argument: (teamId, creditorId), from: this);

  @override
  String toString() => r'paySelectionProvider';
}
