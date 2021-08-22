import 'package:aking/logic/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseTaskRepository {
  Stream<List<Task>> getAllTasks(String uid);
}

class TaskRepository extends BaseTaskRepository {
  final FirebaseFirestore _firebaseFirestore;

  TaskRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Task>> getAllTasks(String uid) {
    return _firebaseFirestore
        .collection('tasks')
        .where("participants", arrayContains: uid)
        // .orderBy("remind", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return Task.fromJson(data);
            }).toList());
  }
}
