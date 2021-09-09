import 'package:aking/logic/models/firestore_doc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

abstract class FirestoreRepository<T extends FirestoreDoc> {
  final FirebaseFirestore _firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collectionRef;

  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  FirestoreRepository({
    FirebaseFirestore? firebaseFirestore,
    required this.collectionRef,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<T>> getAllDoc(String uid);

  Future<String?> handleWriteData(Future onHandle) async {
    try {
      await onHandle;
      return null;
    } on FirebaseException catch (e) {
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> updateByObject(T object) {
    return handleWriteData(
        collectionRef.doc(object.id).update(object.toJson()));
  }

  Future<String?> updateWithJson(Map<String, dynamic> json, String id) {
    return handleWriteData(collectionRef.doc(id).update(json));
  }

  Future<String?> deleteObject(String id) {
    return handleWriteData(collectionRef.doc(id).update({'status': false}));
  }

  Future<String?> addObject(T object) {
    return handleWriteData(collectionRef.add(object.toJson()));
  }
}
