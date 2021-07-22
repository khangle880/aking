import 'package:flutter/material.dart';
import 'package:aking/size_config.dart';

import 'components/forgot_password_body.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(24)),
          child: ForgotPasswordBody(),
        ),
      ),
    );
  }
}
