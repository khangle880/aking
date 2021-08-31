import 'package:aking/logic/utils/queries/filter.dart';
import 'logic_extensions.dart';

extension ExtendedMap<K, V> on Map<K, V> {
  Map<K, V> filterByKey(
      {required K pointSelected, required OptionPointFilter option}) {
    Map<K, V> result = {};

    switch (K) {
      case DateTime:
        final point = (pointSelected as DateTime).getOnlyDate();
        result = Map.fromEntries(entries.where((element) {
          final keyValue = element.key as DateTime;
          switch (option) {
            case OptionPointFilter.isEqualTo:
              return keyValue.differenceOnlyDate(point) == 0;

            case OptionPointFilter.isGreaterThan:
              return keyValue.differenceOnlyDate(point) > 0;

            case OptionPointFilter.isGreaterThanOrEqualTo:
              return keyValue.differenceOnlyDate(point) >= 0;

            case OptionPointFilter.isLessThan:
              return keyValue.differenceOnlyDate(point) < 0;

            case OptionPointFilter.isLessThanOrEqualTo:
              return keyValue.differenceOnlyDate(point) <= 0;

            case OptionPointFilter.isNotEqualTo:
              return keyValue.differenceOnlyDate(point) != 0;
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
