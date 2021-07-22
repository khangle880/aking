import 'dart:collection';

import 'package:flutter/material.dart';

class AuthErrorProvider with ChangeNotifier {
  final List<String> _errors = List.from([]);

  void addError(String value) {
    _errors.add(value);
    notifyListeners();
  }

  void deleteError(String value) {
    _errors.remove(value);
    notifyListeners();
  }

  UnmodifiableListView<String> get listErrors => UnmodifiableListView(_errors);
}
