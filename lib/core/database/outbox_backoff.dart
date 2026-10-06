import 'dart:math' as math;

/// How long to wait before retrying an outbox entry that failed [attempts]
/// times: 5 s, 10 s, 20 s… capped at one hour.
Duration outboxBackoff(int attempts) {
  const base = Duration(seconds: 5);
  const cap = Duration(hours: 1);
  final exponent = math.min(math.max(attempts - 1, 0), 20);
  final delay = base * math.pow(2, exponent).toInt();
  return delay > cap ? cap : delay;
}
