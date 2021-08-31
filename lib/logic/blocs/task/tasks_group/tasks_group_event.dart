part of 'tasks_group_bloc.dart';

abstract class TasksGroupEvent extends Equatable {
  const TasksGroupEvent();

  @override
  List<Object> get props => [];
}

class TasksGroupByDate extends TasksGroupEvent {
  final List<Task> tasks;

  const TasksGroupByDate({required this.tasks});

  @override
  List<Object> get props => [tasks];
}
