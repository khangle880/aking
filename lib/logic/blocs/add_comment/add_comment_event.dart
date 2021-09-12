part of 'add_comment_bloc.dart';

///
abstract class AddCommentEvent extends Equatable {
  const AddCommentEvent();

  @override
  List<Object> get props => [];
}

/// update content of comment
class ContentOnChange extends AddCommentEvent {
  final String content;
  const ContentOnChange({
    required this.content,
  });

  @override
  List<Object> get props => [content];
}

/// show image picker source option
class ShowImagePicker extends AddCommentEvent {}

/// send comment to server
class SendComment extends AddCommentEvent {}
