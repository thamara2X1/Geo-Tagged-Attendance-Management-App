import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Emits the current time every second so the Home screen clock is live.
final clockProvider = StreamProvider<DateTime>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
});
