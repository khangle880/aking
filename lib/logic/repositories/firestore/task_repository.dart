import 'dart:developer';

import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/firestore/project_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';

import 'base_firestore_repository.dart';

class TaskRepository extends FirestoreRepository<Task> {
  TaskRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : super(
          firebaseFirestore: firebaseFirestore,
          collectionRef: (firebaseFirestore ?? FirebaseFirestore.instance)
              .collection('tasks'),
        );

  @override
  Stream<List<Task>> getAllDoc(String uid) {
    return firebaseFirestore
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

  @override
  Future<String?> addObject(Task task) {
    return handleWriteData(
      firebaseFirestore.collection('tasks').add(task.toJson()).then(
        (value) async {
          if (task.members != null) {
            List<String> projectParticipants = [];
            await firebaseFirestore
                .collection('projects')
                .doc(task.projectId)
                .get()
                .then((documentSnapshot) {
              if (documentSnapshot.exists) {
                final data = documentSnapshot.data();
                data!['id'] = documentSnapshot.id;
                projectParticipants = Project.fromJson(data).participants;
              }
            });
            return firebaseFirestore
                .collection('projects')
                .doc(task.projectId)
                .update({
              "participants":
                  <String>{...task.members!, ...projectParticipants}.toList()
            });
          }
        },
      ),
    );
  }

  // @override
  // Future<String?> updateByObject(Task task) async {
  //   return handleWriteData(firebaseFirestore
  //       .collection('tasks')
  //       .doc(task.id)
  //       .update(task.toJson()));
  // }

  // @override
  // Future<String?> updateWithJson(Map<String, dynamic> json, String id) async {
  //   return handleWriteData(
  //       firebaseFirestore.collection('tasks').doc(id).update(json));
  // }

  // @override
  // Future<String?> deleteObject(String id) async {
  //   return handleWriteData(firebaseFirestore
  //       .collection('tasks')
  //       .doc(id)
  //       .update({'status': false}));
  // }
}
