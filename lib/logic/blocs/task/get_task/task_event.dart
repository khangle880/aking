part of 'task_bloc.dart';

class FilterByStatusTasks extends FirestoreEvent<Task> {
  final OptionTaskStatusFilter optionFilter;

  const FilterByStatusTasks(this.optionFilter);

  @override
  List<Object> get props => [optionFilter];
}

class ViewTask extends FirestoreEvent<Task> {
  final String id;
  const ViewTask({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
