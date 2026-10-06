// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_debts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Las deudas que siguen ligadas a un pago.

@ProviderFor(paymentDebts)
final paymentDebtsProvider = PaymentDebtsFamily._();

/// Las deudas que siguen ligadas a un pago.

final class PaymentDebtsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Debt>>,
          List<Debt>,
          Stream<List<Debt>>
        >
    with $FutureModifier<List<Debt>>, $StreamProvider<List<Debt>> {
  /// Las deudas que siguen ligadas a un pago.
  PaymentDebtsProvider._({
    required PaymentDebtsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'paymentDebtsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paymentDebtsHash();

  @override
  String toString() {
    return r'paymentDebtsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Debt>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Debt>> create(Ref ref) {
    final argument = this.argument as String;
    return paymentDebts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentDebtsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paymentDebtsHash() => r'2486b02f337a090451eb254e9e9846cff6e69b5c';

/// Las deudas que siguen ligadas a un pago.

final class PaymentDebtsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Debt>>, String> {
  PaymentDebtsFamily._()
    : super(
        retry: null,
        name: r'paymentDebtsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Las deudas que siguen ligadas a un pago.

  PaymentDebtsProvider call(String paymentId) =>
      PaymentDebtsProvider._(argument: paymentId, from: this);

  @override
  String toString() => r'paymentDebtsProvider';
}
