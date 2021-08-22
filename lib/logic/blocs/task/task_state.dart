part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskFiltered extends TaskLoaded {
  final OptionTaskStatusFilter optionFilter;
  const TaskFiltered(this.optionFilter, List<Task> tasks) : super(tasks);
}
