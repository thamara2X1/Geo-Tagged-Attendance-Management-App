import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/attendance_record.dart';
import '../models/attendance_type.dart';
import 'location_service_provider.dart';

/// Holds the list of attendance records as an AsyncValue so the UI can
/// react to loading / data / error states while GPS is being captured.
final attendanceProvider =
    AsyncNotifierProvider<AttendanceNotifier, List<AttendanceRecord>>(
  AttendanceNotifier.new,
);

class AttendanceNotifier extends AsyncNotifier<List<AttendanceRecord>> {
  final _uuid = const Uuid();

  @override
  Future<List<AttendanceRecord>> build() async {
    return [];
  }

  Future<void> _mark(AttendanceType type) async {
    final previous = state.value ?? [];
    state = const AsyncValue.loading();

    // guard() converts any thrown LocationException into AsyncError
    // automatically — no manual try/catch needed.
    state = await AsyncValue.guard(() async {
      final position =
          await ref.read(locationServiceProvider).getCurrentLocation();

      final record = AttendanceRecord(
        id: _uuid.v4(),
        dateTime: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
        type: type,
      );

      // Newest first.
      return [record, ...previous];
    });

    // If capture failed, restore the previous list so history isn't lost.
    if (state.hasError) {
      final error = state.error!;
      final stack = state.stackTrace!;
      state = AsyncValue<List<AttendanceRecord>>.data(previous)
          .copyWithPrevious(AsyncValue.error(error, stack));
    }
  }

  Future<void> checkIn() => _mark(AttendanceType.checkIn);
  Future<void> checkOut() => _mark(AttendanceType.checkOut);
}
