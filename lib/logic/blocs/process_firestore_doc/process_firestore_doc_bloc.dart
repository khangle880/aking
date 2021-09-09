import 'dart:async';
import 'dart:developer';

import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/firestore_doc.dart';
import 'package:aking/logic/repositories/firestore/base_firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'process_firestore_doc_event.dart';

class ProcessFSDocBloc<T extends FirestoreDoc>
    extends Bloc<ProcessFSDocEvent<T>, ProcessState> {
  ProcessFSDocBloc(this.firestoreRepository) : super(ProcessInitial());
  final FirestoreRepository<T> firestoreRepository;

  @override
  Stream<ProcessState> mapEventToState(
    ProcessFSDocEvent<T> event,
  ) async* {
    if (event is UpdateFSDocByObject<T>) {
      yield* mapProcessToState(
          firestoreRepository.updateByObject(event.object));
    } else if (event is UpdateFSDocByJson<T>) {
      yield* mapProcessToState(
          firestoreRepository.updateWithJson(event.json, event.docId));
    } else if (event is DeleteFSDoc<T>) {
      yield* mapProcessToState(firestoreRepository.deleteObject(event.docId));
    } else {
      yield* mapMoreEventToState(event);
    }
  }

  Stream<ProcessState> mapMoreEventToState(ProcessFSDocEvent event) async* {}

  Stream<ProcessState> mapProcessToState(Future<String?> onProcess) async* {
    yield Processing();
    log('processing');
    final String? error = await onProcess;
    if (error == null) {
      yield ProcessSuccess();
      yield ProcessInitial();
    } else {
      yield ProcessFailure(error);
      yield ProcessInitial();
    }
  }
}
