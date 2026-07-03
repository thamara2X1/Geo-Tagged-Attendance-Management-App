import 'package:flutter/material.dart';

import '../models/attendance_model.dart';
import '../utils/date_formatter.dart';

/// One row in the Attendance History list.
class AttendanceListTile extends StatelessWidget {
  final AttendanceRecord record;
  final VoidCallback onTap;

  const AttendanceListTile({
    super.key,
    required this.record,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCheckIn = record.type == AttendanceType.checkIn;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor:
              isCheckIn ? Colors.green.shade100 : Colors.orange.shade100,
          child: Icon(
            isCheckIn ? Icons.login : Icons.logout,
            color: isCheckIn ? Colors.green : Colors.orange,
          ),
        ),
        title: Text(record.type.label,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormatterUtil.formatDateTime(record.dateTime)),
            const SizedBox(height: 2),
            Text(
              '${record.latitude.toStringAsFixed(6)}, '
              '${record.longitude.toStringAsFixed(6)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
