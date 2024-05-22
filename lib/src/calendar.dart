import 'package:flutter/material.dart';
import 'package:simple_table_calendar/src/customization/calendar_style.dart';
import 'package:simple_table_calendar/src/shared/utils.dart';
import 'package:simple_table_calendar/src/widgets/calendar_base.dart';
import 'package:simple_table_calendar/src/widgets/calendar_header.dart';

class TableCalender extends StatefulWidget {
  TableCalender({
    super.key,
    required DateTime firstDay,
    required DateTime lastDay,
    required DateTime? selectedDay,
    this.sixWeekMonthsEnforced = false,
    CalendarStyle? calendarStyle,
    required this.onDaySelected,
    this.enabledDays,
  })  : firstDay = normalizeDate(firstDay)!,
        lastDay = normalizeDate(lastDay)!,
        selectedDay = normalizeDate(selectedDay),
        calendarStyle = calendarStyle ?? CalendarStyle();
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime? selectedDay;
  final Function(DateTime) onDaySelected;
  final bool sixWeekMonthsEnforced;
  final CalendarStyle calendarStyle;
  final List<DateTime>? enabledDays;

  @override
  State<TableCalender> createState() => _TableCalenderState();
}

class _TableCalenderState extends State<TableCalender> {
  late final PageController _pageController;
  late DateTime focusedMonth;

  @override
  void initState() {
    focusedMonth = DateTime.now();
    final initialPage =
        _getMonthCount(widget.firstDay, widget.selectedDay ?? DateTime.now());
    _pageController = PageController(initialPage: initialPage);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TableCalender oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDay != widget.selectedDay) {
      final initialPage =
          _getMonthCount(widget.firstDay, widget.selectedDay ?? DateTime.now());
      _pageController.jumpToPage(initialPage);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: <Widget>[
          CalendarHeader(
            headerStyle: widget.calendarStyle.headerStyle,
            focusedMonth: focusedMonth,
            currentPageIndex: _getMonthCount(widget.firstDay, focusedMonth),
            maxPageIndex: _getMonthCount(widget.firstDay, widget.lastDay),
            onBack: () {
              if (!(focusedMonth.month == widget.firstDay.month &&
                  focusedMonth.year == widget.firstDay.year)) {
                setState(() {
                  focusedMonth = DateTime.utc(
                      focusedMonth.year, focusedMonth.month - 1, 5);
                });
              }
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            onForward: () {
              if (!(focusedMonth.month == widget.lastDay.month &&
                  focusedMonth.year == widget.lastDay.year)) {
                setState(() {
                  focusedMonth = DateTime.utc(
                      focusedMonth.year, focusedMonth.month + 1, 5);
                });
              }
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          CalendarBase(
            firstDay: widget.firstDay,
            lastDay: widget.lastDay,
            selectedDay: widget.selectedDay,
            sixWeekMonthsEnforced: widget.sixWeekMonthsEnforced,
            onDaySelected: widget.onDaySelected,
            focusedMonth: focusedMonth,
            pageController: _pageController,
            monthCount: _getMonthCount(widget.firstDay, widget.lastDay) + 1,
            calendarStyle: widget.calendarStyle,
            enabledDays: widget.enabledDays,
          ),
        ],
      ),
    );
  }

  int _getMonthCount(DateTime first, DateTime last) {
    final yearDif = last.year - first.year;
    final monthDif = last.month - first.month;

    return yearDif * 12 + monthDif;
  }
}
