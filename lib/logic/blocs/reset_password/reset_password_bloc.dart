import 'dart:async';

import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/logic/utils/errors/auth_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final UserRepository _userRepository;
  String email = "";

  ResetPasswordBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ResetPasswordInitial());

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is ResetPassSendRequest) {
      yield* _mapResetPassSendRequestToState(emailRequest: event.email);
    } else if (event is ResetPassWithEmailPressed) {
      yield* _mapResetPassWithEmailPressedToState(
          email: email, password: event.password, resetCode: event.resetCode);
    }
  }

  Stream<ResetPasswordState> _mapResetPassSendRequestToState({
    required String emailRequest,
  }) async* {
    yield ResetPasswordLoading();
    final requestStatus =
        await _userRepository.requestResetPassword(emailRequest);
    email = emailRequest;
    if (requestStatus) {
      yield ResetPasswordRequestSuccess();
    } else {
      yield ResetPasswordRequestFailure();
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
