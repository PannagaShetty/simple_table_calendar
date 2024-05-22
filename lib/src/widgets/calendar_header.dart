import 'package:flutter/material.dart';
import 'package:simple_table_calendar/src/customization/header_style.dart';
import 'package:simple_table_calendar/src/shared/calendar_enum.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    this.onBack,
    this.onForward,
    required this.focusedMonth,
    required this.headerStyle,
    required this.currentPageIndex,
    required this.maxPageIndex,
  });
  final Function()? onBack;
  final Function()? onForward;
  final DateTime focusedMonth;
  final HeaderStyle headerStyle;
  final int currentPageIndex;
  final int maxPageIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: headerStyle.padding,
      margin: headerStyle.margin,
      child: Row(
        children: [
          Text(
            '${Months.values[focusedMonth.month - 1].shortName} ${focusedMonth.year}',
            style: headerStyle.headerTextStyle,
          ),
          const Spacer(),
          IconButton(
            onPressed: currentPageIndex == 0 ? null : onBack,
            icon: headerStyle.leftArrowIcon == null
                ? Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: headerStyle.arrowSize,
                    color: currentPageIndex == 0
                        ? headerStyle.disabledArrowColor
                        : headerStyle.arrowColor,
                  )
                : headerStyle.leftArrowIcon!,
          ),
          IconButton(
            onPressed: currentPageIndex == maxPageIndex ? null : onForward,
            icon: headerStyle.rightArrowIcon == null
                ? Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: headerStyle.arrowSize,
                    color: currentPageIndex == maxPageIndex
                        ? headerStyle.disabledArrowColor
                        : headerStyle.arrowColor,
                  )
                : headerStyle.rightArrowIcon!,
          ),
        ],
      ),
    );
  }
}
