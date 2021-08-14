part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final TaskList tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskFiltered extends TaskLoaded {
  final OptionTaskStatusFilter optionFilter;
  const TaskFiltered(this.optionFilter, TaskList tasks) : super(tasks);
}
