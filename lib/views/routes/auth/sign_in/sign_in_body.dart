import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sign_in_form.dart';

class SignInBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Welcome Back',
        style: textTheme.headline4,
      ),
      SizedBox(height: 10.h),
      Text('Sign in to continue',
          style: textTheme.bodyText2!.copyWith(color: hexToColor("#9B9B9B")),
          textAlign: TextAlign.left),
      SizedBox(height: 40.h),
      SignInForm(),
    ]);
  }
}
