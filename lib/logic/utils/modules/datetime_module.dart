import 'package:intl/intl.dart';

String toRelativeFormat(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final dateTimeFormatted = DateFormat('MMM d/yyyy').format(dateTime);

  final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
  if (aDate == today) {
    return "TODAY, $dateTimeFormatted";
  } else if (aDate == yesterday) {
    return "YESTERDAY, $dateTimeFormatted";
  } else if (aDate == tomorrow) {
    return "TOMORROW, $dateTimeFormatted";
  } else {
    return DateFormat('EEE, ').format(dateTime) + dateTimeFormatted;
  }
}

DateTime getDateByLocal(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}
