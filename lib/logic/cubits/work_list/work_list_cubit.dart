import 'package:aking/logic/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum WorkListState {
  processing,
  grouped,
}

class WorkListCubit extends Cubit<WorkListState> {
  WorkListCubit({required this.tasks}) : super(WorkListState.processing);

  final List<Task> tasks;
  Map<DateTime, List<Task>> tasksByDate = {};
  final SlidableController slidableController = SlidableController();

  void groupByDate() {
    emit(WorkListState.processing);
    tasksByDate = tasks.groupAndSortByTime();
    emit(WorkListState.grouped);
  }

  void filterByProject(String projectId) {
    emit(WorkListState.processing);
    tasksByDate = tasks
        .where((element) => element.projectId == projectId)
        .toList()
        .groupAndSortByTime();
    emit(WorkListState.grouped);
  }
}
