part of 'process_firestore_doc_bloc.dart';

abstract class ProcessFirestoreDocEvent<T> extends Equatable {
  const ProcessFirestoreDocEvent();

  @override
  List<Object> get props => [];
}

class UpdateFSDocByObject<T> extends ProcessFirestoreDocEvent<T> {
  final T object;
  const UpdateFSDocByObject({
    required this.object,
  });

  @override
  List<Object> get props => [object.hashCode];
}

class UpdateFSDocByJson<T> extends ProcessFirestoreDocEvent<T> {
  final Map<String, dynamic> json;
  final String docId;
  const UpdateFSDocByJson({
    required this.json,
    required this.docId,
  });

  @override
  List<Object> get props => [json, docId];
}
