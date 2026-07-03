import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/attendance_provider.dart';
import '../widgets/attendance_list_tile.dart';
import 'details_screen.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(attendanceProvider).records;
    // Most recent first.
    final sortedRecords = records.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance History')),
      body: sortedRecords.isEmpty
          ? const Center(
              child: Text(
                'No attendance records yet.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: sortedRecords.length,
              itemBuilder: (context, index) {
                final record = sortedRecords[index];
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
