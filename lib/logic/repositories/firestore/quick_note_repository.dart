import 'dart:async';
import 'dart:developer';

import 'package:aking/logic/models/quick_note.dart';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'base_firestore_repository.dart';

class QuickNoteRepository extends FirestoreRepository<QuickNote> {
  final FirebaseFirestore _firebaseFirestore;

  QuickNoteRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<QuickNote>> getAllDoc(String uid) {
    final userRef = _firebaseFirestore.collection('users').doc(uid);
    final stream1 = userRef.collection('note').snapshots();
    final stream2 = userRef.collection('check_list').snapshots();

    return CombineLatestStream.combine2(stream1, stream2,
        (QuerySnapshot<Map<String, dynamic>> a,
            QuerySnapshot<Map<String, dynamic>> b) {
      final docs = a.docs + b.docs;
      final mapedData = docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return QuickNote.fromJson(data);
      }).toList();
      return mapedData;
    });
  }
}
