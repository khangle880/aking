import 'package:flutter/material.dart';
import 'package:aking/size_config.dart';

import 'components/sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24)),
            child: SignInBody()),
      ),
    );
  }
}
