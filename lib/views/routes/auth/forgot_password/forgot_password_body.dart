import 'package:aking/views/utils/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'forgot_password_form.dart';

class ForgotPasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const description = '''
Please enter your email below to receive 
your password reset instructions''';

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Forgot Password',
        style: Theme.of(context).textTheme.headline4,
      ),
      SizedBox(height: 10.h),
      Text(description,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: ExpandedColor.fromHex("#9B9B9B")),
          textAlign: TextAlign.left),
      SizedBox(height: 40.h),
      ForgotPasswordForm(),
    ]);
  }
}
