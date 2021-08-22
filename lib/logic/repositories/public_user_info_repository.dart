import 'package:aking/logic/models/public_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BasePublicUserInfoRepository {
  Stream<List<PublicUserInfo>> getAllPublicUserInfo();
}

class PublicUserInfoRepository extends BasePublicUserInfoRepository {
  final FirebaseFirestore _firebaseFirestore;

  PublicUserInfoRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<PublicUserInfo>> getAllPublicUserInfo() {
    return _firebaseFirestore
        .collection('public_users_info')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return PublicUserInfo.fromJson(data);
            }).toList());
  }
}
