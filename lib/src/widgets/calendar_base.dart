import 'package:flutter/material.dart';
import 'package:simple_table_calendar/src/customization/calendar_style.dart';
import 'package:simple_table_calendar/src/shared/calendar_enum.dart';
import 'package:simple_table_calendar/src/shared/utils.dart';
import 'package:simple_table_calendar/src/widgets/calendar_table.dart';

class CalendarBase extends StatelessWidget {
  const CalendarBase({
    super.key,
    required this.firstDay,
    required this.lastDay,
    required this.selectedDay,
    required pageController,
    required this.onDaySelected,
    this.sixWeekMonthsEnforced = false,
    required this.focusedMonth,
    required this.monthCount,
    required this.calendarStyle,
    this.enabledDays,
  }) : _pageController = pageController;
  final PageController _pageController;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime? selectedDay;
  final bool sixWeekMonthsEnforced;
  final Function(DateTime) onDaySelected;
  final DateTime focusedMonth;
  final int monthCount;
  final CalendarStyle calendarStyle;
  final List<DateTime>? enabledDays;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: SizedBox(
        height: 300,
        child: PageView.builder(
            controller: _pageController,
            itemCount: monthCount,
            itemBuilder: (context, index) {
              final baseDay = _getBaseDay(index);
              final visibleRange = _daysInMonth(baseDay);
              final visibleDays =
                  _daysInRange(visibleRange.start, visibleRange.end);

              return CalendarTable(
                firstDay: firstDay,
                lastDay: lastDay,
                selectedDay: selectedDay,
                sixWeekMonthsEnforced: sixWeekMonthsEnforced,
                onDaySelected: onDaySelected,
                focusedMonth: focusedMonth,
                visibleDays: visibleDays,
                calendarStyle: calendarStyle,
                enabledDays: enabledDays,
              );
            }),
      ),
    );
  }

  List<DateTime> _daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  _getBaseDay(int index) {
    DateTime day;

    day = DateTime.utc(firstDay.year, firstDay.month + index);
    if (day.isBefore(firstDay)) {
      day = firstDay;
    } else if (day.isAfter(lastDay)) {
      day = lastDay;
    }
    return day;
  }

  DateTimeRange _daysInMonth(DateTime focusedDay) {
    final first = _firstDayOfMonth(focusedDay);
    final daysBefore = _getDaysBefore(first);
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    if (sixWeekMonthsEnforced) {
      final end = firstToDisplay.add(const Duration(days: 42));
      return DateTimeRange(start: firstToDisplay, end: end);
    }

    final last = _lastDayOfMonth(focusedDay);
    final daysAfter = _getDaysAfter(last);
    final lastToDisplay = last.add(Duration(days: daysAfter));

    return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1)
        : DateTime.utc(month.year + 1, 1, 1);
    return date.subtract(const Duration(days: 1));
  }

  int _getDaysBefore(DateTime firstDay) {
    return (firstDay.weekday + 7 - getWeekdayNumber(WeekDays.monday)) % 7;
  }

  int _getDaysAfter(DateTime lastDay) {
    int invertedStartingWeekday = 8 - getWeekdayNumber(WeekDays.monday);

    int daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7);
    if (daysAfter == 7) {
      daysAfter = 0;
    }

    return daysAfter;
  }
}
