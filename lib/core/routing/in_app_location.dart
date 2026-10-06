/// [raw] if it is an in-app location (`/…`), else `null`.
///
/// Rejects `//host` and full URLs, so a link or notification can never send
/// the person somewhere outside the app.
String? inAppLocationOrNull(String? raw) {
  if (raw == null || !raw.startsWith('/') || raw.startsWith('//')) return null;
  return raw;
}
