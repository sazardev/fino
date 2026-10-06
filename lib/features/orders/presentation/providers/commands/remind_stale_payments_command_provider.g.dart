// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remind_stale_payments_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remindStalePaymentsCommand)
final remindStalePaymentsCommandProvider =
    RemindStalePaymentsCommandProvider._();

final class RemindStalePaymentsCommandProvider
    extends
        $FunctionalProvider<
          RemindStalePaymentsCommand,
          RemindStalePaymentsCommand,
          RemindStalePaymentsCommand
        >
    with $Provider<RemindStalePaymentsCommand> {
  RemindStalePaymentsCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindStalePaymentsCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindStalePaymentsCommandHash();

  @$internal
  @override
  $ProviderElement<RemindStalePaymentsCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemindStalePaymentsCommand create(Ref ref) {
    return remindStalePaymentsCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemindStalePaymentsCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemindStalePaymentsCommand>(value),
    );
  }
}

String _$remindStalePaymentsCommandHash() =>
    r'18cb6f9ce58811de43dfaccc5a7b067926548262';
