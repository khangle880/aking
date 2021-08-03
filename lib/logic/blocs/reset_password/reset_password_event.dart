part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPassSendRequest extends ResetPasswordEvent {
  final String email;
  const ResetPassSendRequest({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetPassWithEmailPressed extends ResetPasswordEvent {
  final String password;
  final String resetCode;

  const ResetPassWithEmailPressed(
      {required this.password, required this.resetCode});

  @override
  List<Object> get props => [resetCode, password];
}
