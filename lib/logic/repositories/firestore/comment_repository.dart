import 'package:aking/logic/models/comment.dart';
import 'package:aking/logic/models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_firestore_repository.dart';

class CommentRepository extends FirestoreRepository<Comment> {
  CommentRepository({
    FirebaseFirestore? firebaseFirestore,
    required String id,
  }) : super(
          firebaseFirestore: firebaseFirestore,
          collectionRef: (firebaseFirestore ?? FirebaseFirestore.instance)
              .collection('tasks')
              .doc(id)
              .collection("comments"),
        );

  @override
  Stream<List<Comment>> getAllDoc(String uid) {
    return collectionRef
        .where("status", isEqualTo: true)
        .orderBy("createdDate", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return Comment.fromJson(data);
            }).toList());
  }
}
