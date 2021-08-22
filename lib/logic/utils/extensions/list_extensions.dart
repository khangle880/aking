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
