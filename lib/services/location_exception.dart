/// Typed exception so the UI can show a clean, user-friendly message
/// instead of a raw PlatformException.
class LocationException implements Exception {
  final String message;
  const LocationException(this.message);

  @override
  String toString() => message;
}
