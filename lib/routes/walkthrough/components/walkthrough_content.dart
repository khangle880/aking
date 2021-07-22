import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aking/size_config.dart';

class WalkthroughContent extends StatelessWidget {
  const WalkthroughContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(392),
          child: SvgPicture.asset(
            image,
            width: getProportionateScreenWidth(300),
          ),
        ),
        Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenHeight(24),
              height: getProportionateScreenHeight(30 / 24),
              color: hexToColor("#313131"),
            )),
        SizedBox(height: getProportionateScreenHeight(9)),
        Text(description,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: getProportionateScreenHeight(18),
              height: getProportionateScreenHeight(22 / 18),
              color: hexToColor("#313131").withOpacity(0.8),
            )),
      ],
    );
  }
}
