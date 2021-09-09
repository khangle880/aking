part of 'add_check_list_bloc.dart';

class AddCheckListEvent extends Equatable {
  const AddCheckListEvent();

  @override
  List<Object?> get props => [];
}

class TitleOnChange extends AddCheckListEvent {
  final String title;
  const TitleOnChange({
    required this.title,
  });

  @override
  List<Object> get props => [title];
}

class ThemeColorOnChange extends AddCheckListEvent {
  final Color themeColor;
  const ThemeColorOnChange({
    required this.themeColor,
  });

  @override
  List<Object> get props => [themeColor];
}

class AddCheckItem extends AddCheckListEvent {
  final bool isDone;
  final String description;
  final int index;
  const AddCheckItem({
    required this.index,
    required this.isDone,
    required this.description,
  });

  @override
  List<Object> get props => [isDone, description, index];
}

class RemoveCheckItem extends AddCheckListEvent {
  final int index;
  const RemoveCheckItem({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class UpdateCheckItem extends AddCheckListEvent {
  final bool? isDone;
  final String? description;
  final int index;
  const UpdateCheckItem({
    this.isDone,
    this.description,
    required this.index,
  });

  @override
  List<Object?> get props => [isDone, description, index];
}

class SubmitForm extends AddCheckListEvent {
  const SubmitForm();
}
