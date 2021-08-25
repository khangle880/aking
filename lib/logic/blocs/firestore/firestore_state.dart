part of 'firestore_bloc.dart';

abstract class FirestoreState<T> extends Equatable {
  const FirestoreState();

  @override
  List<Object> get props => [];
}

class FirestoreInitial<T> extends FirestoreState<T> {}

class FirestoreLoading<T> extends FirestoreState<T> {}

class FirestoreLoaded<T> extends FirestoreState<T> {
  final List<T> list;

  const FirestoreLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class FirestoreFinded<T> extends FirestoreLoaded<T> {
  const FirestoreFinded(List<T> list) : super(list);
}
