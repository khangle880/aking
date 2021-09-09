import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ExpandedDateTime on DateTime {
  /// add today, tomorrow, yesterday before date format
  String formatWithToday(
      {String? newPattern, String? locale, String? subPattern = ""}) {
    final aroundWithToday = toAroundWithToday();
    final dateTimeFormatted = DateFormat(newPattern, locale).format(this);

    if (aroundWithToday != null) {
      return "${aroundWithToday.toUpperCase()}, $dateTimeFormatted";
    } else {
      return DateFormat(subPattern).format(this) + dateTimeFormatted;
    }
  }

  /// today, tomorrow, yesterday or date format
  String formatOrAroundToday([String? newPattern, String? locale]) {
    final aroundWithToday = toAroundWithToday();

    if (aroundWithToday != null) {
      return aroundWithToday;
    } else {
      return DateFormat(newPattern).format(this);
    }
  }

  /// today, tomorrow, yesterday or null
  String? toAroundWithToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = getOnlyDate();
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

  DateTime getOnlyDate() {
    return DateTime(year, month, day);
  }

  DateTime addTimeOfDate(TimeOfDay timeOfDay) {
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }

  bool isSameDate(DateTime other) {
    return differenceOnlyDate(other) == 0;
  }

  int differenceOnlyDate(DateTime other) {
    return getOnlyDate().difference(other.getOnlyDate()).inDays;
  }
}
