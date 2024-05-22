import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_table_calendar/src/customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  const CellContent({
    super.key,
    required this.isWeekend,
    required this.isToday,
    required this.isSelected,
    required this.isTodayHighlighted,
    required this.isDisabled,
    required this.day,
    required this.isOutside,
    required this.calendarStyle,
  });

  final bool isWeekend;
  final bool isToday;
  final bool isSelected;
  final bool isTodayHighlighted;
  final bool isDisabled;
  final bool isOutside;
  final String locale = 'en';
  final DateTime day;
  final CalendarStyle calendarStyle;

  @override
  Widget build(BuildContext context) {
    final text = DateFormat.d().format(day);
    final padding = calendarStyle.dayPadding;
    final margin = calendarStyle.dayMargin;
    const alignment = Alignment.center;
    const duration = Duration(milliseconds: 250);
    if (isDisabled) {
      return AnimatedContainer(
        duration: duration,
        margin: margin,
        padding: padding,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        alignment: alignment,
        child: Text(text,
            style: TextStyle(
                color: calendarStyle.disabledDayColor,
                fontSize: calendarStyle.dayFontSize)),
      );
    } else if (isOutside) {
      return AnimatedContainer(
        duration: duration,
        margin: margin,
        padding: padding,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        alignment: alignment,
        child: Text(text,
            style: TextStyle(
                color: calendarStyle.disabledDayColor,
                fontSize: calendarStyle.dayFontSize)),
      );
    } else if (isSelected) {
      return AnimatedContainer(
        duration: duration,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: calendarStyle.selectedMarkerColor,
        ),
        alignment: alignment,
        child: Text(text,
            style: TextStyle(
                color: calendarStyle.selectedDayColor,
                fontSize: calendarStyle.dayFontSize)),
      );
    } else if (isToday) {
      return AnimatedContainer(
        duration: duration,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: calendarStyle.todayMarkerColor,
        ),
        alignment: alignment,
        child: Text(text,
            style: TextStyle(
                color: calendarStyle.visibleDayColor,
                fontSize: calendarStyle.dayFontSize)),
      );
    } else {
      return AnimatedContainer(
        duration: duration,
        margin: margin,
        padding: padding,
        alignment: alignment,
        child: Text(
          text,
          style: TextStyle(
              color: calendarStyle.visibleDayColor,
              fontSize: calendarStyle.dayFontSize),
        ),
      );
    }
  }
}
