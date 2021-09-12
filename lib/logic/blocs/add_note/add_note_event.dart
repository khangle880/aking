part of 'add_note_bloc.dart';

///
class AddNoteEvent extends Equatable {
  const AddNoteEvent();

  @override
  List<Object> get props => [];
}

/// update description of new note
class DescriptionOnChange extends AddNoteEvent {
  final String description;
  const DescriptionOnChange({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}

/// update theme of new note
class ThemeColorOnChange extends AddNoteEvent {
  final Color themeColor;
  const ThemeColorOnChange({
    required this.themeColor,
  });

  @override
  List<Object> get props => [themeColor];
}

/// submit data of note to handle
class SubmitForm extends AddNoteEvent {
  const SubmitForm();
}
