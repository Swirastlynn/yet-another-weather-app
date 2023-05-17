import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String getFormattedDateTime() {
    final dayOfWeek = _getDayOfWeekString(weekday);
    final time = DateFormat.jm().format(this);
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
