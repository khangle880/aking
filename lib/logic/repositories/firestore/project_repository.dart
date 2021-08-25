import 'package:aking/logic/models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_firestore_repository.dart';


class ProjectRepository extends FirestoreRepository<Project> {
  final FirebaseFirestore _firebaseFirestore;

  ProjectRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Project>> getAllDoc(String uid) {
    return _firebaseFirestore
        .collection('projects')
        .where("participants", arrayContains: uid)
        .where("status", isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return Project.fromJson(data);
            }).toList());
  }
}
