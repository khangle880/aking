import 'package:aking/logic/models/task.dart';
import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [list];
}
