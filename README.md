<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

The Simple Table Calender is used to show a table calender to user where they can select a specific date in range given

## Features

you can add custom list of dates withn the range you have given to enable only that days.

## Usage

```dart
TableCalender(
    firstDay: DateTime(2021, 1, 1),
    lastDay: DateTime(2021, 12, 31),
    selectedDay: DateTime(2021, 1, 1),
    onDaySelected: (DateTime day) => print(day),
  ),
```

<!-- ## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more. -->
