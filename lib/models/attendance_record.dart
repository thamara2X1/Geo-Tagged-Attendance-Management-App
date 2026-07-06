import 'attendance_type.dart';

/// Immutable representation of a single attendance event
/// (a check-in or a check-out) with its geo-location.
class AttendanceRecord {
  final String id;
  final DateTime dateTime;
  final double latitude;
  final double longitude;
  final AttendanceType type;

  const AttendanceRecord({
    required this.id,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    required this.type,
  });
}
