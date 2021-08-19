import 'dart:async';
import 'package:aking/logic/models/task_list.dart';
import 'package:aking/logic/models/tasks_grouped.dart';
import 'package:aking/logic/utils/modules/datetime_module.dart';
import "package:collection/collection.dart";

import 'package:aking/logic/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_group_event.dart';
part 'tasks_group_state.dart';

class TasksGroupBloc extends Bloc<TasksGroupEvent, TasksGroupState> {
  TasksGroupBloc() : super(TasksGroupInitial());

  @override
  Stream<TasksGroupState> mapEventToState(
    TasksGroupEvent event,
  ) async* {
    if (event is TasksGroupByDate) {
      final taskList = TaskList(event.tasks);
      yield TasksGroupedByDate(tasksGrouped: taskList.groupAndSortBy());
    }
  }
}
