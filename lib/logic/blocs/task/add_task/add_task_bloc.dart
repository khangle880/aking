import 'dart:async';
import 'dart:developer';

import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/repositories/firestore/task_repository.dart';
import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskState());

  final TaskRepository _taskRepository = TaskRepository();
  final UserRepository _userRepository = UserRepository();

  @override
  Stream<AddTaskState> mapEventToState(
    AddTaskEvent event,
  ) async* {
    if (event is TitleOnChange) {
      yield state.copyWith(title: event.title);
    } else if (event is TitleOnChange) {
      yield state.copyWith(title: event.title);
    } else if (event is DueDateOnChange) {
      yield* _mapDueDateOnchangeToState(event.dueDate, event.timeOfDay);
    } else if (event is ProjectIdOnChange) {
      yield state.copyWith(projectId: event.projectId);
    } else if (event is AssigneeIdOnChange) {
      yield state.copyWith(assigneeId: event.assigneeId);
    } else if (event is DescriptionOnChange) {
      yield state.copyWith(description: event.description);
    } else if (event is FocusingStatusOnChange) {
      yield state.copyWith(focusingStatus: event.focusingStatus);
    } else if (event is ProjectSearchStringOnChange) {
      yield state.copyWith(projectSearchString: event.projectSearchString);
    } else if (event is AssigneeSearchStringOnChange) {
      yield state.copyWith(assigneeSearchString: event.assigneeSearchString);
    } else if (event is MembersOnChange) {
      yield state.copyWith(members: event.members);
    } else if (event is AddMemberToList) {
      final List<String> newMembers =
          state.members == null ? [] : List<String>.from(state.members!);
      newMembers.add(event.memberId);
      yield state.copyWith(members: newMembers);
    } else if (event is SubmitForm) {
      yield* _mapSubmitFormToState();
    }
  }

  Stream<AddTaskState> _mapDueDateOnchangeToState(
      DateTime? dueDate, TimeOfDay? timeOfDay) async* {
    if (dueDate == null || timeOfDay == null) return;
    log("add time of day");
    final newDueDate = dueDate.addTimeOfDate(timeOfDay);
    log(newDueDate.toString());
    yield state.copyWith(dueDate: newDueDate);
  }

  Stream<AddTaskState> _mapSubmitFormToState() async* {
    log("submit");
    yield state.copyWith(addStatus: Processing());
    if (state.assigneeId == "") {
      yield state.copyWith(addStatus: ProcessFailure("Assignee invalid"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else if (state.projectId == "") {
      yield state.copyWith(addStatus: ProcessFailure("Project invalid"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else if (state.title == "") {
      yield state.copyWith(addStatus: ProcessFailure("Title invalid"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else {
      final task = Task(
        assignedToId: state.assigneeId,
        createdDate: DateTime.now(),
        creatorId: _userRepository.getUser()!.uid,
        description: state.description,
        dueDate: state.dueDate,
        isDone: false,
        members: state.members,
        participants: [_userRepository.getUser()!.uid, ...?state.members],
        projectId: state.projectId,
        title: state.title,
        status: true,
        id: DateTime.now().toString(),
      );
      final String? error = await _taskRepository.addTask(task);
      if (error == null) {
        yield state.copyWith(addStatus: ProcessSuccess());
      } else {
        yield state.copyWith(addStatus: ProcessFailure(error));
      }
      yield state.copyWith(addStatus: ProcessInitial());
    }
  }
}
