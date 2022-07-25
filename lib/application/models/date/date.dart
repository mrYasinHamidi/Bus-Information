class Date {
  final int year;
  final int month;
  final int day;

  const Date({
    required this.year,
    required this.month,
    required this.day,
  });

  factory Date.fromDateTime(DateTime? dateTime) {
    if (dateTime == null) return Date.zero();
    return Date(year: dateTime.year, month: dateTime.month, day: dateTime.day);
  }

  const Date.zero()
      : year = 0,
        month = 1,
        day = 1;

  DateTime toDatetime() {
    return DateTime(year, month, day);
  }

  bool isZero() => year == 0 && month == 1 && day == 1;

  bool isAfter(Date other) {
    return hashCode > other.hashCode;
  }

  bool isAfterOrEqual(Date other) {
    return hashCode > other.hashCode;
  }

  bool isBefore(Date other) {
    return hashCode < other.hashCode;
  }

  bool isBeforeOrEqual(Date other) {
    return hashCode <= other.hashCode;
  }

  @override
  int get hashCode => year + month + day;

  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }

  @override
  String toString() {
    return '$day / $month / $year';
  }
}
