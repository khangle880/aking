import 'package:aking/logic/blocs/authentication/authentication_bloc.dart';
import 'package:aking/logic/blocs/login/login_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_body.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => LoginBloc(
              userRepository:
                  context.read<AuthenticationBloc>().userRepository),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 0),
            child: SignInBody(),
          ),
        ),
      ),
    );
  }
}
