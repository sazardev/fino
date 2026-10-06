// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_order_details_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(editOrderDetailsCommand)
final editOrderDetailsCommandProvider = EditOrderDetailsCommandProvider._();

final class EditOrderDetailsCommandProvider
    extends
        $FunctionalProvider<
          EditOrderDetailsCommand,
          EditOrderDetailsCommand,
          EditOrderDetailsCommand
        >
    with $Provider<EditOrderDetailsCommand> {
  EditOrderDetailsCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editOrderDetailsCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editOrderDetailsCommandHash();

  @$internal
  @override
  $ProviderElement<EditOrderDetailsCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EditOrderDetailsCommand create(Ref ref) {
    return editOrderDetailsCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditOrderDetailsCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditOrderDetailsCommand>(value),
    );
  }
}

String _$editOrderDetailsCommandHash() =>
    r'e8dc0516fba6ac4f10433efe5e9505fdc2b836c2';
