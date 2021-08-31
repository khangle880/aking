import 'package:equatable/equatable.dart';

abstract class ProcessState extends Equatable {
  const ProcessState();

  @override
  List<Object?> get props => [];
}

class ProcessInitial extends ProcessState {
  const ProcessInitial();
}

class Processing extends ProcessState {}

class ProcessFailure extends ProcessState {
  final String errorMessage;
  const ProcessFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class ProcessSuccess extends ProcessState {}
