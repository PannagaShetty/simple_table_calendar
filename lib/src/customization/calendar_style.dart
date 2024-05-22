import 'package:flutter/material.dart';
import 'package:simple_table_calendar/src/customization/header_style.dart';

/// Class containing styling and configuration for `TableCalendar`'s content.
class CalendarStyle {
  /// The color of visible days in the calendar.
  final Color visibleDayColor;

  /// The color of selected day in the calendar.
  final Color selectedDayColor;

  /// The color of the marker on selected day in the calendar.
  final Color selectedMarkerColor;

  /// The color of the marker on today's date in the calendar.
  final Color todayMarkerColor;

  /// The color of disabled days in the calendar.
  final Color disabledDayColor;

  /// The color of weekdays in the calendar.
  final Color weekdayColor;

  /// The color of weekends in the calendar.
  final Color weekendColor;

  /// The font size of the day text in the calendar.
  final double dayFontSize;

  /// The font size of the weekday text in the calendar.
  final double weekdayFontSize;

  /// The height of each day cell in the calendar.
  final double dayCellHeight;

  /// The height of each week cell in the calendar.
  final double weekCellHeight;

  /// Whether to highlight today's date in the calendar.
  final bool highlightToday;

  /// The padding around each day cell in the calendar.
  final EdgeInsetsGeometry dayPadding;

  /// The padding around each weekday cell in the calendar.
  final EdgeInsetsGeometry weekdayPadding;

  /// The margin around each day cell in the calendar.
  final EdgeInsetsGeometry dayMargin;

  /// The margin around each weekday cell in the calendar.
  final EdgeInsetsGeometry weekdayMargin;

  /// The style configuration for the calendar header.
  final HeaderStyle headerStyle;

  /// Creates a new instance of [CalendarStyle].
  ///
  /// The [visibleDayColor], [selectedDayColor], [selectedMarkerColor], [todayMarkerColor],
  /// [disabledDayColor], [weekdayColor], [weekendColor], [dayFontSize], [weekdayFontSize],
  /// [dayCellHeight], [weekCellHeight], [highlightToday], [dayPadding], [weekdayPadding],
  /// [dayMargin], and [weekdayMargin] parameters are optional and have default values.
  ///
  /// The [weekendColor] defaults to [weekdayColor] if not provided.
  ///
  /// The [todayMarkerColor] is set to [Colors.transparent] if [highlightToday] is false.
  ///
  /// The [headerStyle] defaults to a new instance of [HeaderStyle].

  CalendarStyle(
      {this.visibleDayColor = Colors.black,
      this.selectedDayColor = Colors.white,
      this.selectedMarkerColor = Colors.blue,
      Color todayMarkerColor = Colors.grey,
      this.disabledDayColor = Colors.grey,
      this.weekdayColor = Colors.black,
      Color? weekendColor,
      this.dayFontSize = 14,
      this.weekdayFontSize = 14,
      this.dayCellHeight = 40,
      this.weekCellHeight = 20,
      this.highlightToday = false,
      this.dayPadding = const EdgeInsets.all(0),
      this.weekdayPadding = const EdgeInsets.all(0),
      this.dayMargin = const EdgeInsets.all(5),
      this.weekdayMargin = const EdgeInsets.all(0),
      HeaderStyle? headerStyle})
      : weekendColor = weekendColor ?? weekdayColor,
        todayMarkerColor =
            highlightToday ? todayMarkerColor : Colors.transparent,
        headerStyle = headerStyle ?? HeaderStyle();
}
