import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFF96060),
    this.textColor = const Color(0xFFFFFFFF),
  }) : super(key: key);

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 48.h,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              primary: ExpandedColor.fromHex("#313131"),
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r))),
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: textColor)),
        ));
  }
}
