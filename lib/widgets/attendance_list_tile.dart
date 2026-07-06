import 'package:flutter/material.dart';
import '../models/attendance_record.dart';
import '../models/attendance_type.dart';
import '../utils/date_formatter.dart';

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
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              isCheckIn ? Colors.green.shade100 : Colors.orange.shade100,
          child: Icon(
            isCheckIn ? Icons.login : Icons.logout,
            color: isCheckIn ? Colors.green.shade700 : Colors.orange.shade700,
          ),
        ),
        title: Text(record.type.label),
        subtitle: Text(DateFormatter.dateTime(record.dateTime)),
        trailing: Text(
          '${record.latitude.toStringAsFixed(4)},\n'
          '${record.longitude.toStringAsFixed(4)}',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: onTap,
      ),
    );
  }
}
