import 'package:flutter/material.dart';

import '../models/attendance_model.dart';
import '../utils/date_formatter.dart';

class DetailsScreen extends StatelessWidget {
  final AttendanceRecord record;

  const DetailsScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(label: 'Type', value: record.type.label),
                const Divider(height: 28),
                _DetailRow(
                  label: 'Date',
                  value: DateFormatterUtil.formatDate(record.dateTime),
                ),
                const Divider(height: 28),
                _DetailRow(
                  label: 'Time',
                  value: DateFormatterUtil.formatTime(record.dateTime),
                ),
                const Divider(height: 28),
                _DetailRow(
                  label: 'Latitude',
                  value: record.latitude.toStringAsFixed(6),
                ),
                const Divider(height: 28),
                _DetailRow(
                  label: 'Longitude',
                  value: record.longitude.toStringAsFixed(6),
                ),
              ],
            ),
          ),
        ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 15)),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
