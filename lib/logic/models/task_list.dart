import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/models/tasks_grouped.dart';
import 'package:aking/logic/utils/modules/datetime_module.dart';
import 'package:equatable/equatable.dart';
import "package:collection/collection.dart";

enum OptionTaskStatusFilter { none, incomplete, completed }

class TaskList extends Equatable {
  final List<Task> list;

  const TaskList(this.list);

  TaskList filterByStatus({required OptionTaskStatusFilter option}) {
    List<Task> result = [];
    switch (option) {
      case OptionTaskStatusFilter.none:
        result = list;
        break;

      case OptionTaskStatusFilter.completed:
        result = list.where((element) => element.isDone).toList();
        break;

      case OptionTaskStatusFilter.incomplete:
        result = list.where((element) => !element.isDone).toList();
        break;

      default:
    }
    return TaskList(result);
  }

  TasksGrouped<DateTime> groupAndSortBy() {
    final groupedList =
        groupBy(list, (Task obj) => getDateByLocal(obj.dueDate ?? obj.createdDate));
    final sortedKeys = groupedList.keys.toList(growable: false)..sort();
    final Map<DateTime, List<Task>> result = {
      for (var k in sortedKeys) k: groupedList[k]!
    };
    return TasksGrouped(result);
  }

  @override
  List<Object?> get props => [list];
}
