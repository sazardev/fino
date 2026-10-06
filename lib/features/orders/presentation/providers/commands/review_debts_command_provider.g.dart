// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_debts_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reviewDebtsCommand)
final reviewDebtsCommandProvider = ReviewDebtsCommandProvider._();

final class ReviewDebtsCommandProvider
    extends
        $FunctionalProvider<
          ReviewDebtsCommand,
          ReviewDebtsCommand,
          ReviewDebtsCommand
        >
    with $Provider<ReviewDebtsCommand> {
  ReviewDebtsCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewDebtsCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewDebtsCommandHash();

  @$internal
  @override
  $ProviderElement<ReviewDebtsCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReviewDebtsCommand create(Ref ref) {
    return reviewDebtsCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewDebtsCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewDebtsCommand>(value),
    );
  }
}

String _$reviewDebtsCommandHash() =>
    r'16e12bb7d86623fd44eb72138fe7d57fb888d41a';
