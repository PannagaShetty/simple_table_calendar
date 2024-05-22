
The Simple Table Calender is used to show a table calender to user where they can select a specific date in range given

## Features

you can add custom list of dates withn the range you have given to enable only that days.

## Usage

Add the below code in your project and customize accordingly

```dart
TableCalender(
    firstDay: DateTime(2021, 1, 1),
    lastDay: DateTime(2021, 12, 31),
    selectedDay: DateTime(2021, 1, 1),
    onDaySelected: (DateTime day) => print(day),
  ),
```

## Additional information

For any queries contact: shettypannaga003@gmail.com