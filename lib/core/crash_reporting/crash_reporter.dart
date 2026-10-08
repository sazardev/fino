/// Reports crashes and handled errors. The app talks to this, never to
/// Firebase Crashlytics.
abstract interface class CrashReporter {
  Future<void> setCollectionEnabled({required bool enabled});

  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    bool fatal = false,
  });
}
