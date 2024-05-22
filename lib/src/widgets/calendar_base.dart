import 'package:flutter/material.dart';
import 'package:simple_table_calendar/src/customization/calendar_style.dart';
import 'package:simple_table_calendar/src/shared/calendar_enum.dart';
import 'package:simple_table_calendar/src/shared/utils.dart';
import 'package:simple_table_calendar/src/widgets/calendar_table.dart';

class CalendarBase extends StatefulWidget {
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
  State<CalendarBase> createState() => _CalendarBaseState();
}

class _CalendarBaseState extends State<CalendarBase> {
  late final ValueNotifier<double> _pageHeight;
  @override
  void initState() {
    _pageHeight =
        ValueNotifier(_getPageHeight(widget.sixWeekMonthsEnforced ? 6 : 5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {},
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            widget._pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            widget._pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: ValueListenableBuilder<double>(
          valueListenable: _pageHeight,
          builder: (context, value, child) {
            final height =
                constraints.hasBoundedHeight ? constraints.maxHeight : value;

            return AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: height,
                child: child,
              ),
            );
          },
          child: SizedBox(
            height: 300,
            child: PageView.builder(
                controller: widget._pageController,
                itemCount: widget.monthCount,
                itemBuilder: (context, index) {
                  final baseDay = _getBaseDay(index);
                  final visibleRange = _daysInMonth(baseDay);
                  final visibleDays =
                      _daysInRange(visibleRange.start, visibleRange.end);

                  return CalendarTable(
                    firstDay: widget.firstDay,
                    lastDay: widget.lastDay,
                    selectedDay: widget.selectedDay,
                    sixWeekMonthsEnforced: widget.sixWeekMonthsEnforced,
                    onDaySelected: widget.onDaySelected,
                    focusedMonth: widget.focusedMonth,
                    visibleDays: visibleDays,
                    calendarStyle: widget.calendarStyle,
                    enabledDays: widget.enabledDays,
                  );
                }),
          ),
        ),
      );
    });
  }

  double _getPageHeight(int rowCount) {
    return widget.calendarStyle.weekCellHeight +
        rowCount * widget.calendarStyle.dayCellHeight;
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

    day = DateTime.utc(widget.firstDay.year, widget.firstDay.month + index);
    if (day.isBefore(widget.firstDay)) {
      day = widget.firstDay;
    } else if (day.isAfter(widget.lastDay)) {
      day = widget.lastDay;
    }
    return day;
  }

  DateTimeRange _daysInMonth(DateTime focusedDay) {
    final first = _firstDayOfMonth(focusedDay);
    final daysBefore = _getDaysBefore(first);
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    if (widget.sixWeekMonthsEnforced) {
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
