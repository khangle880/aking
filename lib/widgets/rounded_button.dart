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
        height: getProportionateScreenHeight(48),
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
                  fontSize: getProportionateScreenHeight(18),
                  height: getProportionateScreenHeight(22 / 18),
                  fontWeight: FontWeight.bold)),
        ));
  }
}
