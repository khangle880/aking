import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/task/base_task_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRepository extends BaseTaskRepository {
  final FirebaseFirestore _firebaseFirestore;

  TaskRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Task>> getAllTasks(String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .orderBy("remind", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return Task.fromJson(data);
            }).toList());
  }
}
