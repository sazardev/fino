// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_admin_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(transferAdminCommand)
final transferAdminCommandProvider = TransferAdminCommandProvider._();

final class TransferAdminCommandProvider
    extends
        $FunctionalProvider<
          TransferAdminCommand,
          TransferAdminCommand,
          TransferAdminCommand
        >
    with $Provider<TransferAdminCommand> {
  TransferAdminCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transferAdminCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transferAdminCommandHash();

  @$internal
  @override
  $ProviderElement<TransferAdminCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransferAdminCommand create(Ref ref) {
    return transferAdminCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransferAdminCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransferAdminCommand>(value),
    );
  }
}

String _$transferAdminCommandHash() =>
    r'bc1350480813cd913bad7d312e1996094d8dc928';
