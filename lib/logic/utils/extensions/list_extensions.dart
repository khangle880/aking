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

  List<T> difference(List<T> other) {
    return where((element) => !other.contains(element)).toList();
  }
}

extension FirestoreDocList<T extends FirestoreDoc> on List<T> {
  T? findById(String id) {
    if (id == "" || isEmpty) return null;
    final filteredList = where((element) => element.id == id);
    return filteredList.isEmpty ? null : filteredList.first;
  }
}
