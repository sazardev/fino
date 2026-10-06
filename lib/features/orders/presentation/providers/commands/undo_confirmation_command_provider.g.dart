// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'undo_confirmation_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(undoConfirmationCommand)
final undoConfirmationCommandProvider = UndoConfirmationCommandProvider._();

final class UndoConfirmationCommandProvider
    extends
        $FunctionalProvider<
          UndoConfirmationCommand,
          UndoConfirmationCommand,
          UndoConfirmationCommand
        >
    with $Provider<UndoConfirmationCommand> {
  UndoConfirmationCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'undoConfirmationCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$undoConfirmationCommandHash();

  @$internal
  @override
  $ProviderElement<UndoConfirmationCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UndoConfirmationCommand create(Ref ref) {
    return undoConfirmationCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UndoConfirmationCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UndoConfirmationCommand>(value),
    );
  }
}

String _$undoConfirmationCommandHash() =>
    r'1c37f47f3bb2a171c0b145a252f8058a8070ae1e';
