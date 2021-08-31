import 'dart:async';
import 'dart:developer';

import 'package:aking/logic/repositories/firestore/base_firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';

part 'firestore_event.dart';
part 'firestore_state.dart';

class FirestoreBloc<T> extends Bloc<FirestoreEvent<T>, FirestoreState<T>> {
  FirestoreBloc(this.firestoreRepository) : super(FirestoreInitial<T>());

  final FirestoreRepository<T> firestoreRepository;
  List<T> _allDoc = [];
  StreamSubscription? _subscription;

  List<T> get allDoc => _allDoc;

  @override
  Stream<FirestoreState<T>> mapEventToState(
    FirestoreEvent<T> event,
  ) async* {
    if (event is LoadFirestore<T>) {
      yield* _mapLoadFirestoreToState(event.uid);
    } else if (event is UpdateFirestore<T>) {
      yield* _mapUpdateFirestoreToState(event.list);
    } else if (event is FindFirestoreByText<T>) {
      yield* _mapFindFirestoreByTextToState(event.findKey);
    } else {
      yield* mapMoreEventToState(event);
    }
  }

  Stream<FirestoreState<T>> mapMoreEventToState(FirestoreEvent event) async* {}

  Stream<FirestoreState<T>> _mapLoadFirestoreToState(String uid) async* {
    yield FirestoreLoading();
    await Future.delayed(Duration(seconds: 1));
    _subscription?.cancel();
    _subscription = firestoreRepository
        .getAllDoc(uid)
        .listen((docs) => add(UpdateFirestore<T>(docs)));
  }

  Stream<FirestoreState<T>> _mapUpdateFirestoreToState(List<T> docs) async* {
    _allDoc = docs;
    // // TODO: log
    // log(T.toString());
    // log(_allDoc.toString());
    // log(_allDoc.length.toString());
    yield FirestoreLoaded<T>(docs);
  }

  Stream<FirestoreState<T>> _mapFindFirestoreByTextToState(
      String findKey) async* {
    if (state is FirestoreLoaded<T>) {
      final docs = _allDoc.findByText(findKey: findKey);
      yield FirestoreFinded<T>(docs);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
