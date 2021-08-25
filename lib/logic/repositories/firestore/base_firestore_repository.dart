import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/repositories/firestore/project_repository.dart';

abstract class FirestoreRepository<T> {
  Stream<List<T>> getAllDoc(String uid);
}
