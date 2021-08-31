import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

abstract class FirestoreRepository<T> {
  // final FirebaseFirestore _firebaseFirestore;

  // FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  // FirestoreRepository({FirebaseFirestore? firebaseFirestore})
  //     : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

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
}
