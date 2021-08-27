import 'package:aking/logic/models/firestore_doc.dart';

extension ExtendedList<T> on List<T> {
  List<T> clone() => List.from(this);

  List<T> findByText({required String findKey}) {
    if (findKey == '') return clone();
    final List<T> result = where((element) =>
            element.toString().toLowerCase().contains(findKey.toLowerCase()))
        .toList();
    return result;
  }
}

extension FirestoreDocList on List<FirestoreDoc> {
  FirestoreDoc? findById(String uid) {
    if (uid == "" || isEmpty) return null;
    final filteredList = where((element) => element.id == uid);
    return filteredList.isEmpty ? null : filteredList.first;
  }
}
