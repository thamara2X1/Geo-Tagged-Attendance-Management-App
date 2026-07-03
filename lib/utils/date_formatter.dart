import 'package:intl/intl.dart';

/// Small formatting helpers kept in one place.
class DateFormatterUtil {
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  static final DateFormat _timeFormat = DateFormat('hh:mm a');
  static final DateFormat _dateTimeFormat = DateFormat('dd MMM yyyy, hh:mm a');

  static String formatDate(DateTime dateTime) => _dateFormat.format(dateTime);

  static String formatTime(DateTime dateTime) => _timeFormat.format(dateTime);

  static String formatDateTime(DateTime dateTime) =>
      _dateTimeFormat.format(dateTime);
}
