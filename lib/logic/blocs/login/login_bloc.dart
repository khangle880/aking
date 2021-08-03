import 'dart:async';

import 'package:aking/logic/repositories/user_repository.dart';
import 'package:aking/logic/utils/errors/auth_error.dart';
import 'package:aking/logic/utils/validator/auth_validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield LoginLoading();
    final String? error =
        await _userRepository.signInWithCredentials(email, password);
    if (error == null) {
      yield LoginSuccess();
    } else {
      yield LoginFailure(error);
    }
  }
}
