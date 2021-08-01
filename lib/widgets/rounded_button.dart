import 'package:flutter/material.dart';
import 'package:aking/size_config.dart';

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
        height: (48) * SizeConfig.screenHeightBase,
        child: TextButton(
          onPressed: press,
          style: TextButton.styleFrom(
              primary: hexToColor("#313131"),
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontSize: (18) * SizeConfig.screenHeightBase,
                  height: (22 / 18) * SizeConfig.screenHeightBase,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
