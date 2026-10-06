// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_draft_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// El formulario de "Nuevo pedido": cada cambio recalcula el reparto en vivo
/// (`draftSplitProvider`).

@ProviderFor(OrderDraftController)
final orderDraftControllerProvider = OrderDraftControllerProvider._();

/// El formulario de "Nuevo pedido": cada cambio recalcula el reparto en vivo
/// (`draftSplitProvider`).
final class OrderDraftControllerProvider
    extends $NotifierProvider<OrderDraftController, OrderDraft> {
  /// El formulario de "Nuevo pedido": cada cambio recalcula el reparto en vivo
  /// (`draftSplitProvider`).
  OrderDraftControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderDraftControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderDraftControllerHash();

  @$internal
  @override
  OrderDraftController create() => OrderDraftController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderDraft>(value),
    );
  }
}

String _$orderDraftControllerHash() =>
    r'7e0c65ee9074a0ee8dba3bb40203d47aefde0f95';

/// El formulario de "Nuevo pedido": cada cambio recalcula el reparto en vivo
/// (`draftSplitProvider`).

abstract class _$OrderDraftController extends $Notifier<OrderDraft> {
  OrderDraft build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OrderDraft, OrderDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OrderDraft, OrderDraft>,
              OrderDraft,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
