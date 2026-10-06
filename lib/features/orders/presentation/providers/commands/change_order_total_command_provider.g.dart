// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_order_total_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(changeOrderTotalCommand)
final changeOrderTotalCommandProvider = ChangeOrderTotalCommandProvider._();

final class ChangeOrderTotalCommandProvider
    extends
        $FunctionalProvider<
          ChangeOrderTotalCommand,
          ChangeOrderTotalCommand,
          ChangeOrderTotalCommand
        >
    with $Provider<ChangeOrderTotalCommand> {
  ChangeOrderTotalCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changeOrderTotalCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changeOrderTotalCommandHash();

  @$internal
  @override
  $ProviderElement<ChangeOrderTotalCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChangeOrderTotalCommand create(Ref ref) {
    return changeOrderTotalCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChangeOrderTotalCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChangeOrderTotalCommand>(value),
    );
  }
}

String _$changeOrderTotalCommandHash() =>
    r'6933412578f8e2d7510139467da53c7da52408a3';
