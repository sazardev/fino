/// Fechas como se dicen: "Hoy", "Ayer", "12 oct", "12 oct 2025".
abstract final class DateLabel {
  static const _months = [
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic',
  ];

  static String of(DateTime date, {required DateTime now}) {
    final day = _day(date.toLocal());
    final today = _day(now.toLocal());
    final diff = today.difference(day).inDays;
    if (diff == 0) return 'Hoy';
    if (diff == 1) return 'Ayer';
    final label = '${day.day} ${_months[day.month - 1]}';
    return day.year == today.year ? label : '$label ${day.year}';
  }

  /// Hace cuánto: "Ahora", "Hace 5 min", "Hace 3 h"; si pasó un día, la fecha.
  static String ago(DateTime date, {required DateTime now}) {
    final elapsed = now.difference(date);
    if (elapsed.inMinutes < 1) return 'Ahora';
    if (elapsed.inHours < 1) return 'Hace ${elapsed.inMinutes} min';
    if (elapsed.inHours < 24) return 'Hace ${elapsed.inHours} h';
    return of(date, now: now);
  }

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);
}
