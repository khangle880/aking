import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 48.h,
        child: TextButton(
          onPressed: press,
          style: TextButton.styleFrom(
              primary: hexToColor("#313131"),
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: textColor)),
        ));
  }
}
