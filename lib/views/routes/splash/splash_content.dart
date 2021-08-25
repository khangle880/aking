import 'package:aking/global/constants/assets_path.dart';
import 'package:aking/routing/app_routes.dart';
import 'package:aking/routing/routes.dart';
import 'package:aking/views/widgets/fade_widget.dart';
import 'package:aking/views/widgets/simple_rive_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 4000), () {
      AppRoutes.appNav.currentState!
          .pushReplacementNamed(AppRouteNames.wrapperRoute);
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SimpleRiveWidget(
            rivePath: splashRive,
            simpleAnimation: splashSimpleAnimation,
            width: 149.w,
            height: 149.w),
        FadeWidget(
          milliseconds: 2500,
          child: Text(text,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                shadows: const <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 4.0),
                    blurRadius: 4.0,
                    color: Color.fromARGB(64, 0, 0, 0),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
