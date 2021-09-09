part of 'process_firestore_doc_bloc.dart';

abstract class ProcessFSDocEvent<T> extends Equatable {
  const ProcessFSDocEvent();

  @override
  List<Object> get props => [];
}

class DeleteFSDoc<T> extends ProcessFSDocEvent<T> {
  final String docId;

  const DeleteFSDoc({
    required this.docId,
  });

  @override
  List<Object> get props => [docId];
}

class UpdateFSDocByObject<T> extends ProcessFSDocEvent<T> {
  final T object;
  const UpdateFSDocByObject({
    required this.object,
  });

  @override
  List<Object> get props => [object.hashCode];
}

class UpdateFSDocByJson<T> extends ProcessFSDocEvent<T> {
  final Map<String, dynamic> json;
  final String docId;
  const UpdateFSDocByJson({
    required this.json,
    required this.docId,
  });

  @override
  List<Object> get props => [json, docId];
}
