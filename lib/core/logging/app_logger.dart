import 'dart:developer' as developer;

/// Writes to the developer log; `debug` and `info` only when [verbose].
class AppLogger {
  const new({required this.verbose});

  final bool verbose;

  static const _name = 'fino';

  void debug(String message) {
    if (verbose) developer.log(message, name: _name, level: 500);
  }

  void info(String message) {
    if (verbose) developer.log(message, name: _name, level: 800);
  }

  void warning(String message) =>
      developer.log(message, name: _name, level: 900);

  void error(String message, Object error, [StackTrace? stackTrace]) =>
      developer.log(
        message,
        name: _name,
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
}
