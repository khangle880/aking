import 'package:equatable/equatable.dart';

abstract class FirestoreDoc extends Equatable {
  final String id;
  const FirestoreDoc(this.id);
}
