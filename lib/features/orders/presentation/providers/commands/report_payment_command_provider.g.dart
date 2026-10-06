// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_payment_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportPaymentCommand)
final reportPaymentCommandProvider = ReportPaymentCommandProvider._();

final class ReportPaymentCommandProvider
    extends
        $FunctionalProvider<
          ReportPaymentCommand,
          ReportPaymentCommand,
          ReportPaymentCommand
        >
    with $Provider<ReportPaymentCommand> {
  ReportPaymentCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportPaymentCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportPaymentCommandHash();

  @$internal
  @override
  $ProviderElement<ReportPaymentCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportPaymentCommand create(Ref ref) {
    return reportPaymentCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportPaymentCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportPaymentCommand>(value),
    );
  }
}

String _$reportPaymentCommandHash() =>
    r'd301df13f5ba4691b7adf2a9e6ff52daef4c220e';
