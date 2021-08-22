import 'dart:async';
import 'package:aking/logic/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aking/logic/utils/extensions/extensions.dart';

part 'tasks_group_event.dart';
part 'tasks_group_state.dart';

class TasksGroupBloc extends Bloc<TasksGroupEvent, TasksGroupState> {
  TasksGroupBloc() : super(TasksGroupInitial());

  @override
  Stream<TasksGroupState> mapEventToState(
    TasksGroupEvent event,
  ) async* {
    if (event is TasksGroupByDate) {
      yield TasksGroupedByDate(groupedTasks: event.tasks.groupAndSortByTime());
    }
  }
}
