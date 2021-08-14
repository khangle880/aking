import 'package:aking/logic/models/task.dart';
import 'package:aking/logic/utils/modules/datetime_module.dart';
import 'package:aking/logic/utils/queries/filter.dart';
import 'package:equatable/equatable.dart';

class TasksGrouped<T> extends Equatable {
  final Map<T, List<Task>> list;

  const TasksGrouped(this.list);

  Map<T, List<Task>> filterByKey(
      {required T pointSelected, required OptionKeyFilter option}) {
    Map<T, List<Task>> result = {};

    switch (T) {
      case DateTime:
        final point = getDateByLocal(pointSelected as DateTime);
        switch (option) {
          case OptionKeyFilter.isEqualTo:
            result = Map.fromEntries(list.entries.where((element) {
              // print(
              // '${element.key} ${(element.key as DateTime).difference(pointSelected as DateTime).inDays} $pointSelected');
              return (element.key as DateTime).difference(point).inDays == 0;
            }));
            break;

          case OptionKeyFilter.isGreaterThan:
            result = Map.fromEntries(list.entries.where((element) =>
                (element.key as DateTime).difference(point).inDays > 0));
            break;

          case OptionKeyFilter.isGreaterThanOrEqualTo:
            result = Map.fromEntries(list.entries.where((element) =>
                (element.key as DateTime).difference(point).inDays >= 0));
            break;

          case OptionKeyFilter.isLessThan:
            result = Map.fromEntries(list.entries.where((element) =>
                (element.key as DateTime).difference(point).inDays < 0));
            break;

          case OptionKeyFilter.isLessThanOrEqualTo:
            result = Map.fromEntries(list.entries.where((element) =>
                (element.key as DateTime).difference(point).inDays <= 0));
            break;

          case OptionKeyFilter.isNotEqualTo:
            result = Map.fromEntries(
                list.entries.where((element) => element.key != point));
            break;
          default:
        }
        return result;
      default:
        return {};
    }
  }

  @override
  List<Object?> get props => [list];
}
