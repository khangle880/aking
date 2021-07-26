import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:aking/constants.dart';

class AuthProvider with ChangeNotifier {
  String _userName = "";
  String _password = "";
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

  String get userName => _userName;
  String get password => _password;

  void validateUserName(String value) {
    if (_errors.contains(kEmailNullError)) {
      _errors.remove(kEmailNullError);
    }
    if (_errors.contains(kInvalidEmailError)) {
      _errors.remove(kInvalidEmailError);
    }

    if (value.isEmpty) {
      _errors.add(kEmailNullError);
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      _errors.add(kInvalidEmailError);
    }

    notifyListeners();
  }

  void changeUserName(String? value) {
    _userName = value ?? "";
    notifyListeners();
  }

  void validatePassword(String value) {
    if (_errors.contains(kPassNullError)) {
      _errors.remove(kPassNullError);
    }
    if (_errors.contains(kShortPassError)) {
      _errors.remove(kShortPassError);
    }

    if (value.isEmpty) {
      _errors.add(kPassNullError);
    } else if (value.length < 6) {
      _errors.add(kShortPassError);
    }

    notifyListeners();
  }

  void changePassword(String? value) {
    _password = value ?? "";
    notifyListeners();
  }
}
