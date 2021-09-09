part of 'process_task_bloc.dart';

class UpdateCompleteStatus extends ProcessFSDocEvent<Task> {
  final bool completeStatus;
  final String id;

  const UpdateCompleteStatus({
    required this.completeStatus,
    required this.id,
  });

  @override
  List<Object> get props => [completeStatus, id];
}


