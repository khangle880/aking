part of 'add_comment_bloc.dart';

abstract class AddCommentEvent extends Equatable {
  const AddCommentEvent();

  @override
  List<Object> get props => [];
}

class ContentOnChange extends AddCommentEvent {
  final String content;
  const ContentOnChange({
    required this.content,
  });

  @override
  List<Object> get props => [content];
}

class ShowImagePicker extends AddCommentEvent {}

class SendComment extends AddCommentEvent {}
