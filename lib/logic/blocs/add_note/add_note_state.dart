part of 'add_note_bloc.dart';

class AddNoteState extends Equatable {
  final String description;
  final Color themeColor;
  final ProcessState addStatus;

  const AddNoteState({
    this.description = "",
    this.themeColor = Colors.white,
    this.addStatus = const ProcessInitial(),
  });

  @override
  List<Object> get props => [description, themeColor, addStatus];

  AddNoteState copyWith({
    String? description,
    Color? themeColor,
    ProcessState? addStatus,
  }) {
    return AddNoteState(
      description: description ?? this.description,
      themeColor: themeColor ?? this.themeColor,
      addStatus: addStatus ?? this.addStatus,
    );
  }
}
