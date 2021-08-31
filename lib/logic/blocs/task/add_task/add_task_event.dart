part of 'add_task_bloc.dart';

abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}

class AssigneeSearchStringOnChange extends AddTaskEvent {
  const AssigneeSearchStringOnChange({
    required this.assigneeSearchString,
  });
  final String assigneeSearchString;
}

class ProjectSearchStringOnChange extends AddTaskEvent {
  const ProjectSearchStringOnChange({
    required this.projectSearchString,
  });
  final String projectSearchString;
}

class AssigneeIdOnChange extends AddTaskEvent {
  const AssigneeIdOnChange({
    required this.assigneeId,
  });
  final String assigneeId;
}

class ProjectIdOnChange extends AddTaskEvent {
  const ProjectIdOnChange({
    required this.projectId,
  });
  final String projectId;
}

class TitleOnChange extends AddTaskEvent {
  const TitleOnChange({
    required this.title,
  });
  final String title;
}

class DescriptionOnChange extends AddTaskEvent {
  const DescriptionOnChange({
    required this.description,
  });
  final String description;
}

class DueDateOnChange extends AddTaskEvent {
  const DueDateOnChange({
    this.dueDate,
    this.timeOfDay,
  });
  final DateTime? dueDate;
  final TimeOfDay? timeOfDay;
}

class AddMemberToList extends AddTaskEvent {
  const AddMemberToList({
    required this.memberId,
  });
  final String memberId;
}

class MembersOnChange extends AddTaskEvent {
  const MembersOnChange({
    required this.members,
  });
  final List<String> members;
}

class FocusingStatusOnChange extends AddTaskEvent {
  const FocusingStatusOnChange({
    required this.focusingStatus,
  });
  final FocusingStatus focusingStatus;
}

class SubmitForm extends AddTaskEvent {
  const SubmitForm();
}
