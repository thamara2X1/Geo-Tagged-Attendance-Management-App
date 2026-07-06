enum AttendanceType {
  checkIn,
  checkOut;

  String get label => switch (this) {
        AttendanceType.checkIn => 'Check In',
        AttendanceType.checkOut => 'Check Out',
      };
}
