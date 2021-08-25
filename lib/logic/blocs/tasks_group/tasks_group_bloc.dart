import 'dart:async';
import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/task/task_bloc.dart';
import 'package:aking/logic/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aking/logic/utils/extensions/extensions.dart';

part 'tasks_group_event.dart';
part 'tasks_group_state.dart';

class TasksGroupBloc extends Bloc<TasksGroupEvent, TasksGroupState> {
  TasksGroupBloc([this.mainBloc]) : super(TasksGroupInitial()) {
    if (mainBloc == null) return;
    subscription?.cancel();
    subscription = mainBloc!.stream.listen((state) {
      if (state is FirestoreLoaded<Task>) {
        add(TasksGroupByDate(tasks: state.list));
      }
    });
  }

  StreamSubscription? subscription;
  final TaskBloc? mainBloc;

  @override
  Stream<TasksGroupState> mapEventToState(
    TasksGroupEvent event,
  ) async* {
    if (event is TasksGroupByDate) {
      yield TasksGroupedByDate(groupedTasks: event.tasks.groupAndSortByTime());
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
