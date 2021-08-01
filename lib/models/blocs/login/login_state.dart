part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  const LoginState(
      {this.isEmailValid = true,
      this.isPasswordValid = true,
      this.isSubmitting = false,
      this.isSuccess = false,
      this.isFailure = false});

  LoginState update({
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props =>
      [isEmailValid, isFailure, isPasswordValid, isSubmitting, isSuccess];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  const LoginLoading() : super(isSubmitting: true);
}

class LoginSuccess extends LoginState {
  const LoginSuccess() : super(isSuccess: true);
}

class LoginFailure extends LoginState {
  late final String _errorMessage;
  LoginFailure(String errorCode) : super(isFailure: true) {
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
        isEmailValid,
        isFailure,
        isPasswordValid,
        isSubmitting,
        isSuccess,
        _errorMessage,
      ];
}
