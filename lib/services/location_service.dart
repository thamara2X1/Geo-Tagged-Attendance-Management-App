import 'dart:math';

class LocationResult {
  final double latitude;
  final double longitude;

  const LocationResult({required this.latitude, required this.longitude});
}

abstract class LocationService {
  Future<LocationResult> getCurrentLocation();
}

/// Mock implementation.

class MockLocationService implements LocationService {
  static const double _baseLatitude = 6.9271;
  static const double _baseLongitude = 79.8612;

  final Random _random = Random();

  @override
  Future<LocationResult> getCurrentLocation() async {
    // Simulate the small delay a real GPS fix would take.
    await Future.delayed(const Duration(milliseconds: 800));

    final jitterLat = (_random.nextDouble() - 0.5) * 0.01;
    final jitterLng = (_random.nextDouble() - 0.5) * 0.01;

    return LocationResult(
      latitude: _baseLatitude + jitterLat,
      longitude: _baseLongitude + jitterLng,
    );
  }
}
