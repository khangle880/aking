import 'dart:async';

import 'package:aking/global/constants/app_constants.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/project.dart';
import 'package:aking/logic/repositories/firestore/project_repository.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:aking/logic/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'add_project_event.dart';
part 'add_project_state.dart';

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  AddProjectBloc({required this.projectRepo, required this.userRepo})
      : super(AddProjectState());
  final ProjectRepository projectRepo;
  final UserRepository userRepo;

  @override
  Stream<AddProjectState> mapEventToState(
    AddProjectEvent event,
  ) async* {
    if (event is TitleOnChange) {
      yield state.copyWith(title: event.title);
    } else if (event is ThemeColorOnChange) {
      yield state.copyWith(themeColor: event.themeColor);
    } else if (event is SubmitForm) {
      yield* _mapSubmitFormToState();
    }
  }

  Stream<AddProjectState> _mapSubmitFormToState() async* {
    yield state.copyWith(addStatus: Processing());
    if (state.title == "") {
      yield state.copyWith(addStatus: ProcessFailure("Title can not empty"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else if (!ColorConstants.kListColorPickup.contains(state.themeColor)) {
      yield state.copyWith(
          addStatus: ProcessFailure("Theme color has not been selected"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else {
      final project = Project(
        id: DateTime.now().toString(),
        hexColor: state.themeColor.toHex(),
        title: state.title.simplify(),
        createdDate: DateTime.now(),
        creatorId: userRepo.getUser()!.uid,
        participants: [userRepo.getUser()!.uid],
        status: true,
      );
      final String? error = await projectRepo.addObject(project);
      if (error == null) {
        yield state.copyWith(addStatus: ProcessSuccess());
        yield state.copyWith(addStatus: ProcessInitial());
      } else {
        yield state.copyWith(addStatus: ProcessFailure(error));
        yield state.copyWith(addStatus: ProcessInitial());
      }
    }
  }
}
