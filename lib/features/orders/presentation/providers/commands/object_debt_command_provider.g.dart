// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_debt_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(objectDebtCommand)
final objectDebtCommandProvider = ObjectDebtCommandProvider._();

final class ObjectDebtCommandProvider
    extends
        $FunctionalProvider<
          ObjectDebtCommand,
          ObjectDebtCommand,
          ObjectDebtCommand
        >
    with $Provider<ObjectDebtCommand> {
  ObjectDebtCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'objectDebtCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$objectDebtCommandHash();

  @$internal
  @override
  $ProviderElement<ObjectDebtCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ObjectDebtCommand create(Ref ref) {
    return objectDebtCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ObjectDebtCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ObjectDebtCommand>(value),
    );
  }
}

String _$objectDebtCommandHash() => r'dda41b95d5a7f9d4d0599bde8696fb704bcce3ca';
