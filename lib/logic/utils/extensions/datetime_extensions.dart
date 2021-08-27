import 'package:intl/intl.dart';

extension ExpandedDateTime on DateTime {
  String formatWithToday([String? newPattern, String? locale]) {
    final aroundWithToday = toAroundWithToday();
    final dateTimeFormatted = DateFormat(newPattern, locale).format(this);

    if (aroundWithToday != null) {
      return "${aroundWithToday.toUpperCase()}, $dateTimeFormatted";
    } else {
      return DateFormat('EEE, ').format(this) + dateTimeFormatted;
    }
  }

  String formatOrAroundToday([String? newPattern, String? locale]) {
    final aroundWithToday = toAroundWithToday();

    if (aroundWithToday != null) {
      return aroundWithToday;
    } else {
      return DateFormat(newPattern).format(this);
    }
  }

  String? toAroundWithToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = getDateByLocal();
    if (aDate == today) {
      return "Today";
    } else if (aDate == yesterday) {
      return "Yesterday";
    } else if (aDate == tomorrow) {
      return "Tomorrow";
    } else {
      return null;
    }
  }

  DateTime getDateByLocal() {
    return DateTime(year, month, day);
  }
}
