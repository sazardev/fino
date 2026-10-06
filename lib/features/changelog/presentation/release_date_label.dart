const _months = [
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

/// `6 oct 2026`.
String releaseDateLabel(DateTime date) =>
    '${date.day} ${_months[date.month - 1]} ${date.year}';
