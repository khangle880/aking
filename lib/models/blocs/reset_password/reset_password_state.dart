part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

/// Reset password action required
class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

/// Reset password awaiting for reponse
class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading();
}

/// Reset password success
class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess();
}

/// Invalid or errors happen
class ResetPasswordFailure extends ResetPasswordState {
  late final String _errorMessage;
  ResetPasswordFailure(String errorCode) {
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
