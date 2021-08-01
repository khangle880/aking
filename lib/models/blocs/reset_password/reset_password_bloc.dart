import 'dart:async';

import 'package:aking/models/repositories/user_repository.dart';
import 'package:aking/utils/auth_error.dart';
import 'package:aking/utils/auth_validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final UserRepository _userRepository;

  ResetPasswordBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ResetPasswordInitial());

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is ResetPassWithEmailPressed) {
      yield* _mapResetPassWithEmailPressedToState(
          email: event.email,
          password: event.password,
          resetCode: event.resetCode);
    }
  }

  Stream<ResetPasswordState> _mapResetPassWithEmailPressedToState(
      {required String email,
      required String password,
      required String resetCode}) async* {
    yield ResetPasswordLoading();
    final error =
        await _userRepository.resetPassword(email, password, resetCode);
    if (error == null) {
      yield ResetPasswordSuccess();
    } else {
      yield ResetPasswordFailure(error);
    }
  }
}
