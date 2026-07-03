/// Represents whether a record is a Check In or Check Out event.
enum AttendanceType { checkIn, checkOut }

extension AttendanceTypeLabel on AttendanceType {
  String get label {
    switch (this) {
      case AttendanceType.checkIn:
        return 'Check In';
      case AttendanceType.checkOut:
        return 'Check Out';
    }
  }
}

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'dateTime': dateTime.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
        'type': type.name,
      };

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      type: AttendanceType.values.byName(json['type'] as String),
    );
  }
}
