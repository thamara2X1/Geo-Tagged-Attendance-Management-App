import 'package:flutter/material.dart';
import '../models/attendance_record.dart';
import '../utils/date_formatter.dart';

class DetailsScreen extends StatelessWidget {
  final AttendanceRecord record;
  const DetailsScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DetailRow(label: 'Type', value: record.type.label),
          _DetailRow(label: 'Date', value: DateFormatter.date(record.dateTime)),
          _DetailRow(label: 'Time', value: DateFormatter.time(record.dateTime)),
          _DetailRow(label: 'Latitude', value: record.latitude.toString()),
          _DetailRow(label: 'Longitude', value: record.longitude.toString()),
          _DetailRow(label: 'Record ID', value: record.id),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: theme.textTheme.titleMedium),
          const Divider(height: 24),
        ],
      ),
    );
  }
}
