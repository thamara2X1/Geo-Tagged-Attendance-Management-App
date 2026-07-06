import 'package:geolocator/geolocator.dart';
import 'location_service.dart';

/// Returns fixed coordinates (Colombo) with a tiny jitter.
class MockLocationService implements LocationService {
  @override
  Future<Position> getCurrentLocation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final jitter = (DateTime.now().second % 10) * 0.0001;
    return Position(
      latitude: 6.9271 + jitter,
      longitude: 79.8612 + jitter,
      timestamp: DateTime.now(),
      accuracy: 5,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }
}
