part of 'tasks_group_bloc.dart';

abstract class TasksGroupState extends Equatable {
  const TasksGroupState();

  @override
  List<Object> get props => [];
}

class TasksGroupInitial extends TasksGroupState {}

enum OptionFilter {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
}

class TasksGroupedByDate extends TasksGroupState {
  final TasksGrouped<DateTime> tasksGrouped;

  const TasksGroupedByDate({required this.tasksGrouped});

  @override
  List<Object> get props => [tasksGrouped];
}

//  Map<DateTime, List<Task>> filterByDate(
//       {required DateTime datePicked, required OptionFilter option}) {
//     Map<DateTime, List<Task>> result = {};
//     switch (option) {
//       case OptionFilter.isEqualTo:
//         result = Map.fromEntries(tasksGrouped.entries.where(
//             (element) => element.key.difference(datePicked).inDays == 0));
//         break;

//       case OptionFilter.isGreaterThan:
//         result = Map.fromEntries(tasksGrouped.entries
//             .where((element) => element.key.difference(datePicked).inDays > 0));
//         break;

//       case OptionFilter.isGreaterThanOrEqualTo:
//         result = Map.fromEntries(tasksGrouped.entries.where(
//             (element) => element.key.difference(datePicked).inDays >= 0));
//         break;

//       case OptionFilter.isLessThan:
//         result = Map.fromEntries(tasksGrouped.entries
//             .where((element) => element.key.difference(datePicked).inDays < 0));
//         break;

//       case OptionFilter.isLessThanOrEqualTo:
//         result = Map.fromEntries(tasksGrouped.entries.where(
//             (element) => element.key.difference(datePicked).inDays <= 0));
//         break;

//       case OptionFilter.isNotEqualTo:
//         result = Map.fromEntries(
//             tasksGrouped.entries.where((element) => element.key != datePicked));
//         break;
//       default:
//     }
//     return result;
//   }
