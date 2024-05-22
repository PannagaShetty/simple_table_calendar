import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:simple_table_calendar/src/customization/calendar_style.dart';
import 'package:simple_table_calendar/src/shared/calendar_enum.dart';
import 'package:simple_table_calendar/src/shared/utils.dart';
import 'package:simple_table_calendar/src/widgets/cell_contents.dart';

class CalendarTable extends StatelessWidget {
  const CalendarTable({
    super.key,
    required this.firstDay,
    required this.lastDay,
    required this.selectedDay,
    required this.sixWeekMonthsEnforced,
    required this.onDaySelected,
    required this.focusedMonth,
    required this.visibleDays,
    required this.calendarStyle,
    this.enabledDays,
  });
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime? selectedDay;
  final bool sixWeekMonthsEnforced;
  final Function(DateTime) onDaySelected;
  final DateTime focusedMonth;
  final List<DateTime> visibleDays;
  final CalendarStyle calendarStyle;
  final List<DateTime>? enabledDays;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        _buildWeekDays(context),
        ..._buildDays(context, visibleDays),
      ],
    );
  }

  TableRow _buildWeekDays(BuildContext context) {
    return TableRow(
      children: List.generate(
        7,
        (index) => SizedBox(
            height: calendarStyle.weekCellHeight,
            child: Center(
              child: Text(
                WeekDays.values[index].shortName,
                style: TextStyle(
                  color: [WeekDays.sunday, WeekDays.saturday]
                          .contains(WeekDays.values[index])
                      ? calendarStyle.weekendColor
                      : calendarStyle.weekdayColor,
                  fontSize: calendarStyle.weekdayFontSize,
                ),
              ),
            )),
      ).toList(),
    );
  }

  List<TableRow> _buildDays(
    BuildContext context,
    List<DateTime> visibleDays,
  ) {
    return List.generate(
      visibleDays.length ~/ 7,
      (indexRow) => TableRow(
        children: List.generate(
            7,
            (index) => GestureDetector(
                  onTap: () {
                    final day = visibleDays[indexRow * 7 + index];
                    developer.log('Day Tapped: $day');
                    final isOutside = day.month != focusedMonth.month;

                    if (!isOutside && _isDayInEnabledList(day)) {
                      onDaySelected(day);
                      developer.log('selectedDay updated');
                    }
                  },
                  child: SizedBox(
                    height: calendarStyle.dayCellHeight,
                    child: _buildCell(
                        visibleDays[indexRow * 7 + index], focusedMonth),
                  ),
                )).toList(),
      ),
    );
  }

  Widget _buildCell(DateTime day, DateTime focusedMonth) {
    final isOutside = day.month != focusedMonth.month;
    return LayoutBuilder(builder: (context, constraints) {
      final shorterSide = constraints.maxHeight > constraints.maxWidth
          ? constraints.maxWidth
          : constraints.maxHeight;
      final isToday = isSameDay(day, normalizeDate(DateTime.now()));
      final isDisabled = _isDayDisabled(day);
      final isWeekend = checkIsWeekend(day,
          weekendDays: [DateTime.saturday, DateTime.sunday]);
      final isFocused = isSameDay(day, selectedDay);

      return SizedBox(
          height: shorterSide,
          child: CellContent(
            isOutside: isOutside,
            isWeekend: isWeekend,
            isToday: isToday,
            isSelected: isFocused,
            isTodayHighlighted: true,
            isDisabled: isDisabled,
            day: day,
            calendarStyle: calendarStyle,
          ));
    });
  }

  bool _isDayDisabled(DateTime day) {
    if (day.isBefore(firstDay) || day.isAfter(lastDay)) {
      return true;
    } else if (!_isDayInEnabledList(day)) {
      return true;
    } else {
      return false;
    }
  }

  bool _isDayInEnabledList(DateTime day) {
    if (enabledDays != null) {
      return enabledDays!.any((element) => (element.year == day.year &&
          element.month == day.month &&
          element.day == day.day));
    } else {
      return true;
    }
  }
}
