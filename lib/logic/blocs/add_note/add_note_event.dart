part of 'add_note_bloc.dart';

class AddNoteEvent extends Equatable {
  const AddNoteEvent();

  @override
  List<Object> get props => [];
}

class DescriptionOnChange extends AddNoteEvent {
  final String description;
  const DescriptionOnChange({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}

class ThemeColorOnChange extends AddNoteEvent {
  final Color themeColor;
  const ThemeColorOnChange({
    required this.themeColor,
  });

  @override
  List<Object> get props => [themeColor];
}

class SubmitForm extends AddNoteEvent {
  const SubmitForm();
}
