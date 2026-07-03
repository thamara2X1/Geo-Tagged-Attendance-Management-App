import 'package:flutter/material.dart';

/// Generic full-width action button with an optional loading spinner.
/// Used for both Check In and Check Out so styling stays consistent.
class AttendanceActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onPressed;

  const AttendanceActionButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          disabledBackgroundColor: color.withOpacity(0.4),
        ),
        onPressed: isEnabled && !isLoading ? onPressed : null,
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
