part of 'process_quick_note_bloc.dart';

class UpdateCLItemCompleteStatus extends ProcessFSDocEvent<QuickNote> {
  final bool completeStatus;
  final CheckItem checkItem;
  final CheckList checkList;
  final String uid;

  const UpdateCLItemCompleteStatus({
    required this.completeStatus,
    required this.checkItem,
    required this.checkList,
    required this.uid,
  });

  @override
  List<Object> get props => [completeStatus, checkItem, checkList, uid];
}
