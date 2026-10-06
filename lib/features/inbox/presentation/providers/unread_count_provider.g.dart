// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Cuántas notificaciones sin leer tengo (el número sobre "Buzón").

@ProviderFor(unreadCount)
final unreadCountProvider = UnreadCountProvider._();

/// Cuántas notificaciones sin leer tengo (el número sobre "Buzón").

final class UnreadCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  /// Cuántas notificaciones sin leer tengo (el número sobre "Buzón").
  UnreadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadCountHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return unreadCount(ref);
  }
}

String _$unreadCountHash() => r'f9f9a12648d02fbd6210551bd185ae1924b55573';
