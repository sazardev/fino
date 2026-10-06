// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_timeline_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// La bitácora del pedido tal como la puedo ver (SPEC §11).

@ProviderFor(orderTimeline)
final orderTimelineProvider = OrderTimelineFamily._();

/// La bitácora del pedido tal como la puedo ver (SPEC §11).

final class OrderTimelineProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LedgerEntry>>,
          List<LedgerEntry>,
          Stream<List<LedgerEntry>>
        >
    with
        $FutureModifier<List<LedgerEntry>>,
        $StreamProvider<List<LedgerEntry>> {
  /// La bitácora del pedido tal como la puedo ver (SPEC §11).
  OrderTimelineProvider._({
    required OrderTimelineFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'orderTimelineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$orderTimelineHash();

  @override
  String toString() {
    return r'orderTimelineProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<LedgerEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<LedgerEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return orderTimeline(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderTimelineProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$orderTimelineHash() => r'2661d23c75784ab09a6f7d0d5512d7e83d48c7f4';

/// La bitácora del pedido tal como la puedo ver (SPEC §11).

final class OrderTimelineFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<LedgerEntry>>, String> {
  OrderTimelineFamily._()
    : super(
        retry: null,
        name: r'orderTimelineProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// La bitácora del pedido tal como la puedo ver (SPEC §11).

  OrderTimelineProvider call(String orderId) =>
      OrderTimelineProvider._(argument: orderId, from: this);

  @override
  String toString() => r'orderTimelineProvider';
}
