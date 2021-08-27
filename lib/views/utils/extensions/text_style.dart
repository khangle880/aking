import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/widgets.dart';

extension ExpandedTextStyle on TextStyle {
  TextStyle toBlurColor() {
    return copyWith(color: hexToColor("#9E9E9E"));
  }
}
