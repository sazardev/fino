// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crash_reporter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app-wide crash reporter (overridden in bootstrap with the instance the
/// error handlers already hold, so there is a single one).

@ProviderFor(crashReporter)
final crashReporterProvider = CrashReporterProvider._();

/// The app-wide crash reporter (overridden in bootstrap with the instance the
/// error handlers already hold, so there is a single one).

final class CrashReporterProvider
    extends $FunctionalProvider<CrashReporter, CrashReporter, CrashReporter>
    with $Provider<CrashReporter> {
  /// The app-wide crash reporter (overridden in bootstrap with the instance the
  /// error handlers already hold, so there is a single one).
  CrashReporterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'crashReporterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$crashReporterHash();

  @$internal
  @override
  $ProviderElement<CrashReporter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CrashReporter create(Ref ref) {
    return crashReporter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CrashReporter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CrashReporter>(value),
    );
  }
}

String _$crashReporterHash() => r'350e1bd2b77d1c452b9046fa1893ce5230ecff45';
