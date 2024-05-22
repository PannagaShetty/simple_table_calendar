import 'package:flutter/material.dart';
import 'package:simple_table_calendar/simple_table_calendar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Container(
          color: Colors.yellow,
          height: 350,
          child: TableCalender(
            firstDay: DateTime(2021, 1, 1),
            lastDay: DateTime(2021, 12, 31),
            selectedDay: DateTime(2021, 1, 1),
            onDaySelected: (DateTime day) => print(day),
          ),
        )),
      ),
    );
  }
}
