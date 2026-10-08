// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_monitor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(performanceMonitor)
final performanceMonitorProvider = PerformanceMonitorProvider._();

final class PerformanceMonitorProvider
    extends
        $FunctionalProvider<
          PerformanceMonitor,
          PerformanceMonitor,
          PerformanceMonitor
        >
    with $Provider<PerformanceMonitor> {
  PerformanceMonitorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'performanceMonitorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$performanceMonitorHash();

  @$internal
  @override
  $ProviderElement<PerformanceMonitor> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PerformanceMonitor create(Ref ref) {
    return performanceMonitor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PerformanceMonitor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PerformanceMonitor>(value),
    );
  }
}

String _$performanceMonitorHash() =>
    r'1bccdd7d388cd72ac99234c638bd19bff5e77472';
