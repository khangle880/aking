import 'package:aking/logic/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_firestore_repository.dart';

class TaskRepository extends FirestoreRepository<Task> {
  final FirebaseFirestore _firebaseFirestore;

  TaskRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Task>> getAllDoc(String uid) {
    return _firebaseFirestore
        .collection('tasks')
        .where("participants", arrayContains: uid)
        .where("status", isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return Task.fromJson(data);
            }).toList());
  }
}
