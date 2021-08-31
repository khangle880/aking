part of 'task_bloc.dart';

class FilterByStatusTasks extends FirestoreEvent<Task> {
  final OptionTaskStatusFilter optionFilter;

  const FilterByStatusTasks(this.optionFilter);

  @override
  List<Object> get props => [optionFilter];
}
