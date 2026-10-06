// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_selection_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Qué deudas quedaron fuera del pago que se está armando (SPEC §6.3). Se
/// guarda lo excluido: una deuda que llega mientras tanto entra sola.

@ProviderFor(PaySelectionController)
final paySelectionControllerProvider = PaySelectionControllerFamily._();

/// Qué deudas quedaron fuera del pago que se está armando (SPEC §6.3). Se
/// guarda lo excluido: una deuda que llega mientras tanto entra sola.
final class PaySelectionControllerProvider
    extends $NotifierProvider<PaySelectionController, Set<String>> {
  /// Qué deudas quedaron fuera del pago que se está armando (SPEC §6.3). Se
  /// guarda lo excluido: una deuda que llega mientras tanto entra sola.
  PaySelectionControllerProvider._({
    required PaySelectionControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'paySelectionControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paySelectionControllerHash();

  @override
  String toString() {
    return r'paySelectionControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PaySelectionController create() => PaySelectionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PaySelectionControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paySelectionControllerHash() =>
    r'4f2f35d341a421d63634dc326a9a80f749bf23fe';

/// Qué deudas quedaron fuera del pago que se está armando (SPEC §6.3). Se
/// guarda lo excluido: una deuda que llega mientras tanto entra sola.

final class PaySelectionControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          PaySelectionController,
          Set<String>,
          Set<String>,
          Set<String>,
          (String, String)
        > {
  PaySelectionControllerFamily._()
    : super(
        retry: null,
        name: r'paySelectionControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Qué deudas quedaron fuera del pago que se está armando (SPEC §6.3). Se
  /// guarda lo excluido: una deuda que llega mientras tanto entra sola.

  PaySelectionControllerProvider call(String teamId, String creditorId) =>
      PaySelectionControllerProvider._(
        argument: (teamId, creditorId),
        from: this,
      );

  @override
  String toString() => r'paySelectionControllerProvider';
}

/// Qué deudas quedaron fuera del pago que se está armando (SPEC §6.3). Se
/// guarda lo excluido: una deuda que llega mientras tanto entra sola.

abstract class _$PaySelectionController extends $Notifier<Set<String>> {
  late final _$args = ref.$arg as (String, String);
  String get teamId => _$args.$1;
  String get creditorId => _$args.$2;

  Set<String> build(String teamId, String creditorId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
