import 'package:intl/intl.dart';

extension ExpandedDateTime on DateTime {
  String toRelativeFormat([String? newPattern, String? locale]) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final dateTimeFormatted = DateFormat(newPattern, locale).format(this);

    final aDate = getDateByLocal();
    if (aDate == today) {
      return "TODAY, $dateTimeFormatted";
    } else if (aDate == yesterday) {
      return "YESTERDAY, $dateTimeFormatted";
    } else if (aDate == tomorrow) {
      return "TOMORROW, $dateTimeFormatted";
    } else {
      return DateFormat('EEE, ').format(this) + dateTimeFormatted;
    }
  }

  DateTime getDateByLocal() {
    return DateTime(year, month, day);
  }
}
