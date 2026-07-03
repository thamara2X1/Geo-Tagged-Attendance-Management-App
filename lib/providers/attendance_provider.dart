import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/attendance_model.dart';
import '../services/location_service.dart';

class AttendanceState {
  final List<AttendanceRecord> records;
  final bool isLoading;
  final String? errorMessage;

  const AttendanceState({
    this.records = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  AttendanceState copyWith({
    List<AttendanceRecord>? records,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AttendanceState(
      records: records ?? this.records,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          errorMessage,
    );
  }

  AttendanceRecord? get lastRecord => records.isEmpty ? null : records.last;

  bool get isCheckedIn => lastRecord?.type == AttendanceType.checkIn;
}

class AttendanceNotifier extends StateNotifier<AttendanceState> {
  final LocationService _locationService;
  final Uuid _uuid = const Uuid();

  AttendanceNotifier(this._locationService) : super(const AttendanceState());

  Future<void> checkIn() => _logAttendance(AttendanceType.checkIn);
  Future<void> checkOut() => _logAttendance(AttendanceType.checkOut);

  Future<void> _logAttendance(AttendanceType type) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final location = await _locationService.getCurrentLocation();
      final record = AttendanceRecord(
        id: _uuid.v4(),
        dateTime: DateTime.now(),
        latitude: location.latitude,
        longitude: location.longitude,
        type: type,
      );
      state = state.copyWith(
        records: [...state.records, record],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to capture location: $e',
      );
    }
  }
}

final locationServiceProvider = Provider<LocationService>((ref) {
  return MockLocationService();
});

final attendanceProvider =
    StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) {
  final locationService = ref.watch(locationServiceProvider);
  return AttendanceNotifier(locationService);
});
