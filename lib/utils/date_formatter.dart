import 'package:intl/intl.dart';

class DateFormatter {
  static final _date = DateFormat('EEE, dd MMM yyyy');
  static final _time = DateFormat('hh:mm:ss a');
  static final _dateTime = DateFormat('dd MMM yyyy · hh:mm a');

  static String date(DateTime dt) => _date.format(dt);
  static String time(DateTime dt) => _time.format(dt);
  static String dateTime(DateTime dt) => _dateTime.format(dt);
}
