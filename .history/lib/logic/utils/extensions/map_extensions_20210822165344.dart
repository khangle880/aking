import 'package:aking/logic/utils/modules/datetime_module.dart';
import 'package:aking/logic/utils/queries/filter.dart';

extension ExtendedMap<K, V> on Map<K, V> {
  Map<K, V> filterByKey(
      {required K pointSelected, required OptionPointFilter option}) {
    Map<K, V> result = {};

    switch (K) {
      case DateTime:
        final point = getDateByLocal(pointSelected as DateTime);
        result = Map.fromEntries(entries.where((element) {
          final keyValue = element.key as DateTime;
          switch (option) {
            case OptionPointFilter.isEqualTo:
              return keyValue.difference(point).inDays == 0;
            case OptionPointFilter.isGreaterThan:
              return keyValue.difference(point).inDays > 0;

            case OptionPointFilter.isGreaterThanOrEqualTo:
              return keyValue.difference(point).inDays >= 0;

            case OptionPointFilter.isLessThan:
              return keyValue.difference(point).inDays < 0;

            case OptionPointFilter.isLessThanOrEqualTo:
              return keyValue.difference(point).inDays <= 0;

            case OptionPointFilter.isNotEqualTo:
              return keyValue != point;
          }
        }));
        return result;
      default:
        return {};
    }
  }

  Map<K, V> sortByKey() {
    final sortedKeys = keys.toList(growable: false)..sort();
    final Map<K, V> result = {for (var k in sortedKeys) k: this[k]!};
    
    return result;
  }
}
