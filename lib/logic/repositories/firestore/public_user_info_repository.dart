import 'package:aking/logic/models/public_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_firestore_repository.dart';


class PublicUserInfoRepository extends FirestoreRepository<PublicUserInfo> {
  final FirebaseFirestore _firebaseFirestore;

  PublicUserInfoRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<PublicUserInfo>> getAllDoc(String uid) {
    return _firebaseFirestore
        .collection('public_users_info')
        .where("status", isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return PublicUserInfo.fromJson(data);
            }).toList());
  }
}
