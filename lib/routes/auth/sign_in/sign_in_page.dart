import 'package:aking/models/blocs/authentication/authentication_bloc.dart';
import 'package:aking/models/blocs/login/login_bloc.dart';
import 'package:aking/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/sign_in_body.dart';

class SignInPage extends StatelessWidget {
  // final UserRepository _userRepository;

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => LoginBloc(
              userRepository:
                  context.read<AuthenticationBloc>().userRepository),
          child: Padding(
            padding: EdgeInsets.all((24) * SizeConfig.screenWidthBase),
            child: SignInBody(),
          ),
        ),
      ),
    );
  }
}
