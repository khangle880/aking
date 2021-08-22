import 'package:flutter/widgets.dart';

class AddTaskProvider with ChangeNotifier {
  String _assigneeId = '';
  String _projectId = '';
  String _title = '';
  String? _description;
  DateTime? _dueDate;
  List<String>? _members;

  DateTime? get dueDate => _dueDate;
  set dueDate(DateTime? value) {
    _dueDate = value;
    notifyListeners();
  }

  List<String>? get members => _members;
  set members(List<String>? value) {
    _members = value;
    notifyListeners();
  }

  String? get description => _description;
  set description(String? value) {
    _description = value;
    notifyListeners();
  }

  String get assigneeId => _assigneeId;
  set assigneeId(String value) {
    _assigneeId = value;
    notifyListeners();
  }

  String get projectId => _projectId;
  set projectId(String value) {
    _projectId = value;
    notifyListeners();
  }

  String get title => _title;
  set title(String value) {
    _title = value;
    notifyListeners();
  }
}
