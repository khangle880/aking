part of 'add_project_bloc.dart';

abstract class AddProjectEvent extends Equatable {
  const AddProjectEvent();

  @override
  List<Object> get props => [];
}

class TitleOnChange extends AddProjectEvent {
  final String title;
  const TitleOnChange({
    required this.title,
  });

  @override
  List<Object> get props => [title];
}

class ThemeColorOnChange extends AddProjectEvent {
  final Color themeColor;
  const ThemeColorOnChange({
    required this.themeColor,
  });

  @override
  List<Object> get props => [themeColor];
}

class SubmitForm extends AddProjectEvent {
  const SubmitForm();
}
