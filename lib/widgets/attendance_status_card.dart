import 'package:flutter/material.dart';

/// Small display-only card showing current attendance status.
class AttendanceStatusCard extends StatelessWidget {
  final bool isCheckedIn;
  final bool hasRecords;
  final DateTime currentDateTime;

  const AttendanceStatusCard({
    super.key,
    required this.isCheckedIn,
    required this.hasRecords,
    required this.currentDateTime,
  });

  @override
  Widget build(BuildContext context) {
    final String statusText;
    final Color statusColor;

    if (!hasRecords) {
      statusText = 'Not Marked Yet';
      statusColor = Colors.grey;
    } else if (isCheckedIn) {
      statusText = 'Checked In';
      statusColor = Colors.green;
    } else {
      statusText = 'Checked Out';
      statusColor = Colors.orange;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.circle, size: 12, color: statusColor),
                const SizedBox(width: 8),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${currentDateTime.day}/${currentDateTime.month}/${currentDateTime.year}  '
              '${currentDateTime.hour.toString().padLeft(2, '0')}:'
              '${currentDateTime.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
