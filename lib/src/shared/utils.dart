import 'package:simple_table_calendar/src/shared/calendar_enum.dart';

int getWeekdayNumber(WeekDays weekday) {
  return WeekDays.values.indexOf(weekday) + 1;
}

DateTime? normalizeDate(DateTime? date) {
  if (date == null) {
    return null;
  } else {
    return DateTime(date.year, date.month, date.day);
  }
}

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool checkIsWeekend(
  DateTime day, {
  List<int> weekendDays = const [DateTime.saturday, DateTime.sunday],
}) {
  return weekendDays.contains(day.weekday);
}
