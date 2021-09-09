import 'dart:async';

import 'package:aking/global/constants/app_constants.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/note.dart';
import 'package:aking/logic/repositories/firestore/quick_note_repository.dart';
import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:aking/logic/utils/extensions/logic_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_note_event.dart';
part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  AddNoteBloc({required this.quickNoteRepository, required this.userRepo})
      : super(AddNoteState());

  final QuickNoteRepository quickNoteRepository;
  final UserRepository userRepo;

  @override
  Stream<AddNoteState> mapEventToState(
    AddNoteEvent event,
  ) async* {
    if (event is DescriptionOnChange) {
      yield state.copyWith(description: event.description);
    } else if (event is ThemeColorOnChange) {
      yield state.copyWith(themeColor: event.themeColor);
    } else if (event is SubmitForm) {
      yield* _mapSubmitFormToState();
    }
  }

  Stream<AddNoteState> _mapSubmitFormToState() async* {
    yield state.copyWith(addStatus: Processing());
    if (state.description == "") {
      yield state.copyWith(
          addStatus: ProcessFailure("Description can not empty"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else if (!ColorConstants.kListColorPickup.contains(state.themeColor)) {
      yield state.copyWith(
          addStatus: ProcessFailure("Theme color has not been selected"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else {
      final note = Note(
        id: DateTime.now().toString(),
        hexColor: state.themeColor.toHex(),
        description: state.description.simplify(),
        createdDate: DateTime.now(),
        status: true,
      );
      final String? error = await quickNoteRepository.addNote(
          uid: userRepo.getUser()!.uid, object: note);
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
