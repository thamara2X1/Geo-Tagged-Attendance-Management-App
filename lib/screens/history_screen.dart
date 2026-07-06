import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/attendance_provider.dart';
import '../widgets/attendance_list_tile.dart';
import 'details_screen.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceProvider);
    // Keep showing existing records even while a new capture is loading.
    final records = state.valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance History')),
      body: records.isEmpty
          ? const Center(child: Text('No attendance records yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: records.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final record = records[index];
                return AttendanceListTile(
                  record: record,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(record: record),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
