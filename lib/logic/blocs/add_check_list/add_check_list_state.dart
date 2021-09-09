part of 'add_check_list_bloc.dart';

class AddCheckListState extends Equatable {
  final String title;
  final Color themeColor;
  final AnimatedListModel<CheckItem> animatedListModel;
  final ProcessState addStatus;

  const AddCheckListState({
    this.title = '',
    this.themeColor = Colors.white,
    required this.animatedListModel,
    this.addStatus = const ProcessInitial(),
  });

  @override
  List<Object> get props => [title, themeColor, animatedListModel, addStatus];

  AddCheckListState copyWith({
    String? title,
    Color? themeColor,
    AnimatedListModel<CheckItem>? animatedListModel,
    ProcessState? addStatus,
  }) {
    return AddCheckListState(
      title: title ?? this.title,
      themeColor: themeColor ?? this.themeColor,
      animatedListModel: animatedListModel ?? this.animatedListModel,
      addStatus: addStatus ?? this.addStatus,
    );
  }
}
