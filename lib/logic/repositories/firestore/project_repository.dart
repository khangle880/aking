import 'package:aking/logic/models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_firestore_repository.dart';

class ProjectRepository extends FirestoreRepository<Project> {
  ProjectRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : super(
          firebaseFirestore: firebaseFirestore,
          collectionRef: (firebaseFirestore ?? FirebaseFirestore.instance)
              .collection('projects'),
        );

  @override
  Stream<List<Project>> getAllDoc(String uid) {
    return firebaseFirestore
        .collection('projects')
        .where("participants", arrayContains: uid)
        .where("status", isEqualTo: true)
        .orderBy('title', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return Project.fromJson(data);
            }).toList());
  }

  @override
  Future<String?> deleteObject(String id) {
    return handleWriteData(
        collectionRef.doc(id).update({'status': false}).then((value) {
      firebaseFirestore
          .collection("tasks")
          .where("projectId", isEqualTo: id)
          .get()
          .then((snapshot) {
        for (final e in snapshot.docs) {
          e.reference.update({"status": false});
        }
      });
    }));
  }
}
