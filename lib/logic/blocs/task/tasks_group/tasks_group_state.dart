part of 'tasks_group_bloc.dart';

abstract class TasksGroupState extends Equatable {
  const TasksGroupState();

  @override
  List<Object> get props => [];
}

class TasksGroupInitial extends TasksGroupState {}

enum OptionFilter {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
}

class TasksGroupedByDate extends TasksGroupState {
  final Map<DateTime, List<Task>> groupedTasks;

  const TasksGroupedByDate({required this.groupedTasks});

  @override
  List<Object> get props => [groupedTasks];
}
