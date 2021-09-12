part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// update email input text field
class LoginEmailChange extends LoginEvent {
  final String email;

  const LoginEmailChange({required this.email});

  @override
  List<Object> get props => [email];
}

/// update password imput text field
class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

/// login firebase with credentials
class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
