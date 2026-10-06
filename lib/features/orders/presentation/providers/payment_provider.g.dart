// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(payment)
final paymentProvider = PaymentFamily._();

final class PaymentProvider
    extends
        $FunctionalProvider<AsyncValue<Payment?>, Payment?, FutureOr<Payment?>>
    with $FutureModifier<Payment?>, $FutureProvider<Payment?> {
  PaymentProvider._({
    required PaymentFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'paymentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paymentHash();

  @override
  String toString() {
    return r'paymentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Payment?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Payment?> create(Ref ref) {
    final argument = this.argument as String;
    return payment(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paymentHash() => r'900f39bf7741ea7aa0cf2a71d47fe27535e429b2';

final class PaymentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Payment?>, String> {
  PaymentFamily._()
    : super(
        retry: null,
        name: r'paymentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PaymentProvider call(String paymentId) =>
      PaymentProvider._(argument: paymentId, from: this);

  @override
  String toString() => r'paymentProvider';
}
