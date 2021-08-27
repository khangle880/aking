import 'package:flutter/widgets.dart';

enum FocusingStatus {
  none,
  assignee,
  project,
}

class AddTaskProvider with ChangeNotifier {
  String _assigneeId = 'ihVsTJaYuHaJarrXKYISWqq6CNI2';
  String _projectId = '1SNm2QeeT5flSqrwQHln';
  String _assigneeSearchText = '';
  String _projectSearchText = '';
  String _title = '';
  String? _description;
  DateTime? _dueDate;
  List<String>? _members;
  FocusingStatus _focusingStatus = FocusingStatus.none;

  DateTime? get dueDate => _dueDate;
  void changeDueDate(DateTime? value) {
    _dueDate = value;
    notifyListeners();
  }

  List<String>? get members => _members;
  void changeMembers(List<String>? value) {
    _members = value;
    notifyListeners();
  }

  void addMember(String value) {
    _members ??= [];
    _members!.add(value);
    notifyListeners();
  }

  String? get description => _description;
  void changeDescription(String? value) {
    _description = value;
    notifyListeners();
  }

  String? get assigneeSearchText => _assigneeSearchText;
  void changeAssigneeSearchText(String value) {
    _assigneeSearchText = value;
    notifyListeners();
  }

  String? get projectSearchText => _projectSearchText;
  void changeProjectSearchText(String value) {
    _projectSearchText = value;
    notifyListeners();
  }

  String get assigneeId => _assigneeId;
  void selectAssignee(String value) {
    _assigneeId = value;
    notifyListeners();
  }

  String get projectId => _projectId;
  void selectProject(String value) {
    _projectId = value;
    notifyListeners();
  }

  String get title => _title;
  void changeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  FocusingStatus get forcusingStatus => _focusingStatus;
  void changeForcusingStatus(FocusingStatus value) {
    print(value);
    _focusingStatus = value;
    notifyListeners();
  }
}
