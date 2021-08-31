import 'dart:async';

import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/repositories/firestore/base_firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'process_firestore_doc_event.dart';

class ProcessFirestoreDocBloc<T>
    extends Bloc<ProcessFirestoreDocEvent<T>, ProcessState> {
  ProcessFirestoreDocBloc(this.firestoreRepository) : super(ProcessInitial());
  final FirestoreRepository<T> firestoreRepository;

  @override
  Stream<ProcessState> mapEventToState(
    ProcessFirestoreDocEvent<T> event,
  ) async* {
    if (event is UpdateFSDocByObject<T>) {
      yield* _mapUpdateFSDocByObjectToState(event.object);
    } else if (event is UpdateFSDocByJson<T>) {
      yield* _mapUpdateFSDocByJsonToState(event.json, event.docId);
    } else {
      yield* mapMoreEventToState(event);
    }
  }

  Stream<ProcessState> mapMoreEventToState(
      ProcessFirestoreDocEvent event) async* {}

  Stream<ProcessState> _mapUpdateFSDocByObjectToState(T object) async* {}

  Stream<ProcessState> _mapUpdateFSDocByJsonToState(
      Map<String, dynamic> json, String id) async* {}
}
