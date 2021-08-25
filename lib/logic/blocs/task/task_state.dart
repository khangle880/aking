part of 'task_bloc.dart';

class TaskFiltered extends FirestoreLoaded<Task> {
  final OptionTaskStatusFilter optionFilter;
  const TaskFiltered(this.optionFilter, List<Task> tasks) : super(tasks);
}
