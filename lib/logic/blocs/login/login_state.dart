part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

/// Login action required
class LoginInitial extends LoginState {}

/// Login awaiting for reponse
class LoginLoading extends LoginState {
  const LoginLoading();
}

/// Login success
class LoginSuccess extends LoginState {
  const LoginSuccess();
}

/// Invalid or errors happen
class LoginFailure extends LoginState {
  late final String _errorMessage;
  LoginFailure(String errorCode) {
    final error = authErrors[errorCode];
    if (error != null) {
      _errorMessage = error;
    } else {
      _errorMessage = errorCode;
    }
  }

  String get errorMessage => _errorMessage;

  @override
  List<Object?> get props => [
        _errorMessage,
      ];
}
