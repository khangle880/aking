import 'dart:async';

import 'package:aking/logic/blocs/process_firestore_doc/process_firestore_doc_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/firestore/base_firestore_repository.dart';
import 'package:aking/logic/repositories/firestore/task_repository.dart';

part 'process_task_event.dart';

class ProcessTaskBloc extends ProcessFSDocBloc<Task> {
  ProcessTaskBloc(FirestoreRepository<Task> firestoreRepository)
      : super(firestoreRepository);

  @override
  Stream<ProcessState> mapMoreEventToState(
    ProcessFSDocEvent event,
  ) async* {
    if (event is UpdateCompleteStatus) {
      yield* _mapUpdateCompleteStatusToState(event.completeStatus, event.id);
    }
  }

  Stream<ProcessState> _mapUpdateCompleteStatusToState(
      bool completeStatus, String id) async* {
    yield* mapProcessToState((firestoreRepository as TaskRepository)
        .updateWithJson({'isDone': completeStatus}, id));
  }
}
