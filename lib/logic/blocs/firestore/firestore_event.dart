part of 'firestore_bloc.dart';

abstract class FirestoreEvent<T> extends Equatable {
  const FirestoreEvent();

  @override
  List<Object> get props => [];
}

class LoadFirestore<T> extends FirestoreEvent<T> {
  final String uid;
  const LoadFirestore(this.uid);

  @override
  List<Object> get props => [uid];
}

class UpdateFirestore<T> extends FirestoreEvent<T> {
  final List<T> list;

  const UpdateFirestore(this.list);

  @override
  List<Object> get props => [list];
}

class FindFirestoreByText<T> extends FirestoreEvent<T> {
  final String findKey;

  const FindFirestoreByText(this.findKey);

  @override
  List<Object> get props => [findKey];
}


