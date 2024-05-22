enum WeekDays {
  monday('Mon', 'M'),
  tuesday('Tue', 'T'),
  wednesday('Wed', 'W'),
  thursday('Thu', 'T'),
  friday('Fri', 'F'),
  saturday('Sat', 'S'),
  sunday('Sun', 'S');

  const WeekDays(this.shortName, this.firstLetter);
  final String shortName;
  final String firstLetter;
}

enum Months {
  january('January', 'Jan'),
  february('February', 'Feb'),
  march('March', 'Mar'),
  april('April', 'Apr'),
  may('May', 'May'),
  june('June', 'Jun'),
  july('July', 'Jul'),
  august('August', 'Aug'),
  september('September', 'Sep'),
  october('October', 'Oct'),
  november('November', 'Nov'),
  december('December', 'Dec');

  const Months(this.fullName, this.shortName);
  final String fullName;
  final String shortName;
}
