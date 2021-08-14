import 'package:aking/logic/models/task.dart';

enum OptionFilter {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
}
Map<DateTime, List<Task>> filterByDate(
    {required Map<DateTime, List<Task>> tasks,
    required DateTime datePicked,
    required OptionFilter option}) {
  late Map<DateTime, List<Task>> result;
  switch (option) {
    case OptionFilter.isEqualTo:
      result = Map.fromEntries(
          tasks.entries.where((element) => element.key == datePicked));
      break;

    case OptionFilter.isGreaterThan:
      result = Map.fromEntries(
          tasks.entries.where((element) => element.key.isAfter(datePicked)));
      break;

    case OptionFilter.isGreaterThanOrEqualTo:
      result = Map.fromEntries(tasks.entries
          .where((element) => element.key.difference(datePicked).inDays >= 0));
      break;

    case OptionFilter.isLessThan:
      result = Map.fromEntries(
          tasks.entries.where((element) => element.key.isBefore(datePicked)));
      break;

    case OptionFilter.isLessThanOrEqualTo:
      result = Map.fromEntries(tasks.entries
          .where((element) => element.key.difference(datePicked).inDays <= 0));
      break;

    case OptionFilter.isNotEqualTo:
      result = Map.fromEntries(
          tasks.entries.where((element) => element.key != datePicked));
      break;
    default:
  }
  return result;
}
