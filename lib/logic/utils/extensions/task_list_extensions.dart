import 'package:aking/logic/models/task.dart';
import "package:collection/collection.dart";
import 'logic_extensions.dart';

enum OptionTaskStatusFilter { none, incomplete, completed }

extension TaskList on List<Task> {
  List<Task> filterByStatus({required OptionTaskStatusFilter option}) {
    List<Task> result = [];
    switch (option) {
      case OptionTaskStatusFilter.none:
        result = clone();
        break;

      case OptionTaskStatusFilter.completed:
        result = where((element) => element.isDone).toList();
        break;

      case OptionTaskStatusFilter.incomplete:
        result = where((element) => !element.isDone).toList();
        break;

      default:
    }
    return result;
  }

  Map<DateTime, List<Task>> groupAndSortByTime() {
    final groupedList = groupBy(
        this, (Task obj) => (obj.dueDate ?? obj.createdDate).getOnlyDate());
    return groupedList.sortByKey();
  }

  Map<String, List<Task>> groupAndSortByProject() {
    final groupedList = groupBy(this, (Task obj) => obj.projectId);
    return groupedList.sortByKey();
  }
}
