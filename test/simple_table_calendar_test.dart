import 'package:flutter_test/flutter_test.dart';
import 'package:simple_table_calendar/src/calendar.dart';
import 'package:simple_table_calendar/src/customization/calendar_style.dart';

void main() {
  test('TableCalender', () {
    final firstDay = DateTime(2021, 1, 1);
    final lastDay = DateTime(2021, 12, 31);
    final selectedDay = DateTime(2021, 1, 1);
    onDaySelected(DateTime day) => print(day);
    final calendar = TableCalender(
      firstDay: firstDay,
      lastDay: lastDay,
      selectedDay: selectedDay,
      onDaySelected: onDaySelected,
    );
    expect(calendar.firstDay, firstDay);
    expect(calendar.lastDay, lastDay);
    expect(calendar.selectedDay, selectedDay);
    expect(calendar.onDaySelected, onDaySelected);
    expect(calendar.sixWeekMonthsEnforced, false);
    expect(calendar.calendarStyle, CalendarStyle());
    expect(calendar.enabledDays, null);
  });

  test('_TableCalenderState', () {
    final firstDay = DateTime(2021, 1, 1);
    final lastDay = DateTime(2021, 12, 31);
    final selectedDay = DateTime(2021, 1, 1);
    onDaySelected(DateTime day) => print(day);
    final calendar = TableCalender(
      firstDay: firstDay,
      lastDay: lastDay,
      selectedDay: selectedDay,
      onDaySelected: onDaySelected,
    );
    final state = calendar.createState();
    // expect(state.focusedMonth, DateTime.now());
    // expect(state._pageController.initialPage,
    //     state._getMonthCount(firstDay, selectedDay));
    // state.didUpdateWidget(calendar);
    // expect(state._pageController.initialPage,
    //     state._getMonthCount(firstDay, selectedDay));
    state.dispose();
  });
}
