// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(order)
final orderProvider = OrderFamily._();

final class OrderProvider
    extends
        $FunctionalProvider<
          AsyncValue<OrderSummary?>,
          OrderSummary?,
          Stream<OrderSummary?>
        >
    with $FutureModifier<OrderSummary?>, $StreamProvider<OrderSummary?> {
  OrderProvider._({
    required OrderFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderHash();

  @override
  String toString() {
    return r'orderProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<OrderSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<OrderSummary?> create(Ref ref) {
    final argument = this.argument as String;
    return order(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderHash() => r'62ef49fa65c65205737bc32d8fc0be5aae0d1858';

final class OrderFamily extends $Family
    with $FunctionalFamilyOverride<Stream<OrderSummary?>, String> {
  OrderFamily._()
    : super(
        retry: null,
        name: r'orderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrderProvider call(String orderId) =>
      OrderProvider._(argument: orderId, from: this);

  @override
  String toString() => r'orderProvider';
}
