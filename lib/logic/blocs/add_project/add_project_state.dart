part of 'add_project_bloc.dart';

class AddProjectState extends Equatable {
  const AddProjectState({
    this.title = "",
    this.themeColor = Colors.transparent,
    this.addStatus = const ProcessInitial(),
  });
  final String title;
  final Color themeColor;
  final ProcessState addStatus;

  @override
  List<Object> get props => [title, themeColor, addStatus];

  AddProjectState copyWith({
    String? title,
    Color? themeColor,
    ProcessState? addStatus,
  }) {
    return AddProjectState(
      title: title ?? this.title,
      themeColor: themeColor ?? this.themeColor,
      addStatus: addStatus ?? this.addStatus,
    );
  }
}
