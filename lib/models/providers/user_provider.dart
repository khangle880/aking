import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:aking/constants.dart';

class UserProvider with ChangeNotifier {
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
    if (value.isEmpty && !_errors.contains(kEmailNullError)) {
      addError(kEmailNullError);
    } else if (value.isNotEmpty && _errors.contains(kEmailNullError)) {
      deleteError(kEmailNullError);
    } else if (!emailValidatorRegExp.hasMatch(value) &&
        !_errors.contains(kInvalidEmailError)) {
      addError(kInvalidEmailError);
    } else if (emailValidatorRegExp.hasMatch(value) &&
        _errors.contains(kInvalidEmailError)) {
      deleteError(kInvalidEmailError);
    }
  }

  void changeUserName(String? value) {
    _userName = value ?? "";
    notifyListeners();
  }

  void validatePassword(String value) {
    if (value.isEmpty && !_errors.contains(kPassNullError)) {
      addError(kPassNullError);
    } else if (value.isNotEmpty && _errors.contains(kPassNullError)) {
      deleteError(kPassNullError);
    } else if (value.length < 8 && !_errors.contains(kShortPassError)) {
      addError(kShortPassError);
    } else if (value.length >= 8 && _errors.contains(kShortPassError)) {
      deleteError(kShortPassError);
    }
  }

  void changePassword(String? value) {
    _password = value ?? "";
    notifyListeners();
  }
}
