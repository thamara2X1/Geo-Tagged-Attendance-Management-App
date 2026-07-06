import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/location_service.dart';

/// Single injection point for the location source.
/// Swap to MockLocationService() to test without a real device.
final locationServiceProvider = Provider<LocationService>((ref) {
  return GeolocatorLocationService();
});
