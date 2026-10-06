// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redistribute_pending_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(redistributePendingCommand)
final redistributePendingCommandProvider =
    RedistributePendingCommandProvider._();

final class RedistributePendingCommandProvider
    extends
        $FunctionalProvider<
          RedistributePendingCommand,
          RedistributePendingCommand,
          RedistributePendingCommand
        >
    with $Provider<RedistributePendingCommand> {
  RedistributePendingCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redistributePendingCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redistributePendingCommandHash();

  @$internal
  @override
  $ProviderElement<RedistributePendingCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RedistributePendingCommand create(Ref ref) {
    return redistributePendingCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RedistributePendingCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RedistributePendingCommand>(value),
    );
  }
}

String _$redistributePendingCommandHash() =>
    r'e63c705f3be1c4efe99634af3ce58bc70fb33512';
