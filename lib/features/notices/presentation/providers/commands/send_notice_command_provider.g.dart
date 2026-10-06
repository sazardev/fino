// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_notice_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sendNoticeCommand)
final sendNoticeCommandProvider = SendNoticeCommandProvider._();

final class SendNoticeCommandProvider
    extends
        $FunctionalProvider<
          SendNoticeCommand,
          SendNoticeCommand,
          SendNoticeCommand
        >
    with $Provider<SendNoticeCommand> {
  SendNoticeCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendNoticeCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendNoticeCommandHash();

  @$internal
  @override
  $ProviderElement<SendNoticeCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SendNoticeCommand create(Ref ref) {
    return sendNoticeCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendNoticeCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendNoticeCommand>(value),
    );
  }
}

String _$sendNoticeCommandHash() => r'0c578e889c17cb813f8298973f2172e50dd56b69';
