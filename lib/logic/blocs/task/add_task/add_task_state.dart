part of 'add_task_bloc.dart';

enum FocusingStatus {
  none,
  assignee,
  project,
}

class AddTaskState extends Equatable {
  const AddTaskState({
    this.assigneeId = '',
    this.projectId = '',
    this.assigneeSearchString = '',
    this.projectSearchString = '',
    this.title = '',
    this.description,
    this.dueDate,
    this.members,
    this.focusingStatus = FocusingStatus.none,
    this.addStatus = const ProcessInitial(),
  });

  final String assigneeId;
  final String projectId;
  final String assigneeSearchString;
  final String projectSearchString;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final List<String>? members;
  final FocusingStatus focusingStatus;
  final ProcessState addStatus;

  @override
  List<Object?> get props => [
        assigneeId,
        projectId,
        assigneeSearchString,
        projectSearchString,
        title,
        focusingStatus,
        addStatus,
        description,
        dueDate,
        members,
      ];

  AddTaskState copyWith({
    String? assigneeId,
    String? projectId,
    String? assigneeSearchString,
    String? projectSearchString,
    String? title,
    String? description,
    DateTime? dueDate,
    List<String>? members,
    FocusingStatus? focusingStatus,
    ProcessState? addStatus,
  }) {
    return AddTaskState(
      assigneeId: assigneeId ?? this.assigneeId,
      projectId: projectId ?? this.projectId,
      assigneeSearchString: assigneeSearchString ?? this.assigneeSearchString,
      projectSearchString: projectSearchString ?? this.projectSearchString,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      members: members ?? this.members,
      focusingStatus: focusingStatus ?? this.focusingStatus,
      addStatus: addStatus ?? this.addStatus,
    );
  }
}
