part of 'add_comment_bloc.dart';

class AddCommentState extends Equatable {
  final String content;
  final String imagePath;
  final ProcessState addStatus;
  const AddCommentState({
    this.content = '',
    this.imagePath = "",
    this.addStatus = const ProcessInitial(),
  });

  @override
  List<Object> get props => [content, imagePath, addStatus];

  AddCommentState copyWith({
    String? content,
    String? imagePath,
    ProcessState? addStatus,
  }) {
    return AddCommentState(
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      addStatus: addStatus ?? this.addStatus,
    );
  }
}

class AddCommentInitial extends AddCommentState {}
