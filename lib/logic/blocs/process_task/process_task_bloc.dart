import 'dart:async';

import 'package:aking/logic/blocs/process_firestore_doc/process_firestore_doc_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/firestore/base_firestore_repository.dart';
import 'package:aking/logic/repositories/firestore/task_repository.dart';

part 'process_task_event.dart';

class ProcessTaskBloc extends ProcessFirestoreDocBloc<Task> {
  ProcessTaskBloc(FirestoreRepository<Task> firestoreRepository)
      : super(firestoreRepository);

  @override
  Stream<ProcessState> mapEventToState(
    ProcessFirestoreDocEvent<Task> event,
  ) async* {
    if (event is UpdateCompleteStatus) {
      yield* _mapUpdateCompleteStatusToState(event.completeStatus, event.id);
    }
  }

  Stream<ProcessState> _mapUpdateCompleteStatusToState(
      bool completeStatus, String id) async* {
    yield Processing();
    final String? error = await (firestoreRepository as TaskRepository)
        .updateTaskWithJson({'isDone': completeStatus}, id);
    if (error == null) {
      yield ProcessSuccess();
    } else {
      yield ProcessFailure(error);
    }
  }
}
