part of 'add_check_list_bloc.dart';

///
class AddCheckListEvent extends Equatable {
  ///
  const AddCheckListEvent();

  @override
  List<Object?> get props => [];
}

/// update new title of check list for state
class TitleOnChange extends AddCheckListEvent {
  ///
  final String title;

  ///
  const TitleOnChange({
    required this.title,
  });

  @override
  List<Object> get props => [title];
}

/// update new theme of check list for state
class ThemeColorOnChange extends AddCheckListEvent {
  ///
  final Color themeColor;

  ///
  const ThemeColorOnChange({
    required this.themeColor,
  });

  @override
  List<Object> get props => [themeColor];
}

/// Add new item to check list
class AddCheckItem extends AddCheckListEvent {
  /// task is done
  final bool isDone;

  /// descripton of task
  final String description;

  /// index in list
  final int index;

  ///
  const AddCheckItem({
    required this.index,
    required this.isDone,
    required this.description,
  });

  @override
  List<Object> get props => [isDone, description, index];
}

/// Remove new item to check list
class RemoveCheckItem extends AddCheckListEvent {
  /// index in list
  final int index;

  ///
  const RemoveCheckItem({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

/// Update item by index to check list
class UpdateCheckItem extends AddCheckListEvent {
  ///
  final bool? isDone;

  ///
  final String? description;

  ///
  final int index;

  ///
  const UpdateCheckItem({
    this.isDone,
    this.description,
    required this.index,
  });

  @override
  List<Object?> get props => [isDone, description, index];
}

///
class SubmitForm extends AddCheckListEvent {
  ///
  const SubmitForm();
}
