import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aking/models/providers/user_provider.dart';
import 'package:aking/size_config.dart';

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
      Text('Sign in to continue',
          style: textTheme.bodyText1!.copyWith(color: hexToColor("#9B9B9B")),
          textAlign: TextAlign.left),
      MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
          child: SignInForm()),
    ]);
  }
}
