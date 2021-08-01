import 'package:aking/models/blocs/authentication/authentication_bloc.dart';
import 'package:aking/models/blocs/reset_password/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:aking/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_body.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => ResetPasswordBloc(
              userRepository:
                  context.read<AuthenticationBloc>().userRepository),
          child: Padding(
            padding: EdgeInsets.all((24) * SizeConfig.screenWidthBase),
            child: ForgotPasswordBody(),
          ),
        ),
      ),
    );
  }
}
