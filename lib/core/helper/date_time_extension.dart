// Extension for week of the year calculation
extension DateTimeExtension on DateTime {
  int weekOfYear() {
    final firstDayOfYear = DateTime(year, 1, 1);
    final dayOfYear = difference(firstDayOfYear).inDays + 1;
    return ((dayOfYear - weekday + 10) / 7).floor();
  }
}
