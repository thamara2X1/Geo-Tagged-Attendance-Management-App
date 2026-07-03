import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/attendance_provider.dart';
import '../utils/constants.dart';
import '../widgets/attendance_action_button.dart';
import '../widgets/attendance_status_card.dart';
import 'history_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceState = ref.watch(attendanceProvider);
    final notifier = ref.read(attendanceProvider.notifier);
    final isCheckedIn = attendanceState.isCheckedIn;

    ref.listen(attendanceProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Attendance History',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 36,
              child: Icon(Icons.person, size: 36),
            ),
            const SizedBox(height: 12),
            const Text(
              AppConstants.employeeName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            AttendanceStatusCard(
              isCheckedIn: isCheckedIn,
              hasRecords: attendanceState.records.isNotEmpty,
              currentDateTime: DateTime.now(),
            ),
            const SizedBox(height: 32),
            AttendanceActionButton(
              label: 'Check In',
              color: Colors.green,
              isEnabled: !isCheckedIn,
              isLoading: attendanceState.isLoading,
              onPressed: notifier.checkIn,
            ),
            const SizedBox(height: 16),
            AttendanceActionButton(
              label: 'Check Out',
              color: Colors.redAccent,
              isEnabled: isCheckedIn,
              isLoading: attendanceState.isLoading,
              onPressed: notifier.checkOut,
            ),
          ],
        ),
      ),
    );
  }
}
