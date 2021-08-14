part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {
  final String uid;
  const LoadTasks(this.uid);

  @override
  List<Object> get props => [uid];
}

class UpdateTasks extends TaskEvent {
  final List<Task> tasks;

  const UpdateTasks(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class FilterByStatusTasks extends TaskEvent {
  final OptionTaskStatusFilter optionFilter;

  const FilterByStatusTasks(this.optionFilter);

  @override
  List<Object> get props => [optionFilter];
}
