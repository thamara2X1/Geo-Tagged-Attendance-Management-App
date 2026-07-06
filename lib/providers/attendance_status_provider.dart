import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attendance_type.dart';
import 'attendance_provider.dart';

/// Derived state: the employee is "checked in" when the most recent
/// record is a check-in. Drives which button is enabled on Home.
final isCheckedInProvider = Provider<bool>((ref) {
  final records = ref.watch(attendanceProvider).value ?? [];
  if (records.isEmpty) return false;
  return records.first.type == AttendanceType.checkIn;
});
