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
          height: (392) * SizeConfig.screenHeightBase,
          child: SvgPicture.asset(
            image,
            width: (300) * SizeConfig.screenWidthBase,
          ),
        ),
        Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: (24) * SizeConfig.screenHeightBase,
              height: (30 / 24) * SizeConfig.screenHeightBase,
              color: hexToColor("#313131"),
            )),
        SizedBox(height: (9) * SizeConfig.screenHeightBase),
        Text(description,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: (18) * SizeConfig.screenHeightBase,
              height: (22 / 18) * SizeConfig.screenHeightBase,
              color: hexToColor("#313131").withOpacity(0.8),
            )),
      ],
    );
  }
}
