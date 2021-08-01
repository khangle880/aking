part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPassWithEmailPressed extends ResetPasswordEvent {
  final String email;
  final String password;
  final String resetCode;

  const ResetPassWithEmailPressed(
      {required this.email, required this.password, required this.resetCode});

  @override
  List<Object> get props => [email, password];
}
