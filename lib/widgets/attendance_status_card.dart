import 'package:flutter/material.dart';
import '../utils/date_formatter.dart';

class AttendanceStatusCard extends StatelessWidget {
  final String employeeName;
  final DateTime now;
  final bool isCheckedIn;

  const AttendanceStatusCard({
    super.key,
    required this.employeeName,
    required this.now,
    required this.isCheckedIn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employeeName, style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(DateFormatter.date(now), style: theme.textTheme.bodyMedium),
            Text(DateFormatter.time(now), style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  isCheckedIn ? Icons.check_circle : Icons.cancel,
                  color: isCheckedIn ? Colors.green : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isCheckedIn ? 'Checked In' : 'Checked Out',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isCheckedIn ? Colors.green : Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
