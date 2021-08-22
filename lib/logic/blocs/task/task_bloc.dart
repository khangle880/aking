import 'dart:async';

import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/task_repository.dart';
import 'package:aking/logic/utils/extensions/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskInitial());

  final TaskRepository _taskRepository;
  List<Task> _allTask = [];
  StreamSubscription? _taskSubscription;

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is LoadTasks) {
      yield* _mapLoadTasksToState(event.uid);
    } else if (event is UpdateTasks) {
      yield* _mapUpdateTasksToState(event.tasks);
    } else if (event is FilterByStatusTasks) {
      yield* _mapFilterByStatusTasksToState(event.optionFilter);
    }
  }

  Stream<TaskState> _mapLoadTasksToState(String uid) async* {
    _taskSubscription?.cancel();
    _taskSubscription = _taskRepository
        .getAllTasks(uid)
        .listen((tasks) => add(UpdateTasks(tasks)));
  }

  Stream<TaskState> _mapUpdateTasksToState(List<Task> tasks) async* {
    _allTask = tasks;
    await Future.delayed(Duration(milliseconds: 400));
    yield TaskLoaded(tasks);
  }

  Stream<TaskState> _mapFilterByStatusTasksToState(
      OptionTaskStatusFilter optionFilter) async* {
    if (state is TaskLoaded) {
      final tasks = TaskList(_allTask).filterByStatus(option: optionFilter);
      yield TaskFiltered(optionFilter, tasks);
    }
  }
}
