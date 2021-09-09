import 'dart:async';

import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/firestore/task_repository.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends FirestoreBloc<Task> {
  TaskBloc(TaskRepository taskRepository) : super(taskRepository);

  String? currentTask;

  @override
  Stream<FirestoreState<Task>> mapMoreEventToState(
    FirestoreEvent event,
  ) async* {
    if (event is FilterByStatusTasks) {
      yield* _mapFilterByStatusTasksToState(event.optionFilter);
    } else if (event is ViewTask) {
      currentTask = event.id;
    }
  }

  Stream<FirestoreState<Task>> _mapFilterByStatusTasksToState(
      OptionTaskStatusFilter optionFilter) async* {
    if (state is FirestoreLoaded<Task>) {
      final tasks = TaskList(allDoc).filterByStatus(option: optionFilter);
      yield TaskFiltered(optionFilter, tasks);
    }
  }
}
