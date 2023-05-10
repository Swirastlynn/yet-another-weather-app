import 'package:intl/intl.dart';

class DateTimeHelper {
  String getFormattedDateTime() {
    final dateTime = DateTime.now();
    final dayOfWeek = _getDayOfWeekString(dateTime.weekday);
    final time = DateFormat.jm().format(dateTime);
    return '$dayOfWeek, $time';
  }

  String _getDayOfWeekString(int dayOfWeek) {
    switch (dayOfWeek) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}
