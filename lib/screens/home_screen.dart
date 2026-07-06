import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/attendance_provider.dart';
import '../providers/attendance_status_provider.dart';
import '../providers/clock_provider.dart';
import '../utils/app_constants.dart';
import '../widgets/attendance_status_card.dart';
import 'history_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceState = ref.watch(attendanceProvider);
    final isCheckedIn = ref.watch(isCheckedInProvider);
    final clock = ref.watch(clockProvider).value ?? DateTime.now();
    final isLoading = attendanceState.isLoading;

    // Surface errors as a SnackBar (side-effect, not a rebuild).
    ref.listen(attendanceProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(next.error.toString()),
              backgroundColor: Colors.red.shade600,
            ),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AttendanceStatusCard(
              employeeName: AppConstants.employeeName,
              now: clock,
              isCheckedIn: isCheckedIn,
            ),
            const Spacer(),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Center(child: CircularProgressIndicator()),
              ),
            FilledButton.icon(
              onPressed: (isLoading || isCheckedIn)
                  ? null
                  : () => ref.read(attendanceProvider.notifier).checkIn(),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.login),
              label: const Text('Check In'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: (isLoading || !isCheckedIn)
                  ? null
                  : () => ref.read(attendanceProvider.notifier).checkOut(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Check Out'),
            ),
          ],
        ),
      ),
    );
  }
}
