import 'package:aking/models/blocs/reset_password/reset_password_bloc.dart';
import 'package:aking/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reset_password_body.dart';

class ResetPasswordPage extends StatelessWidget {
  final ResetPasswordBloc _resetPasswordBloc;

  const ResetPasswordPage(
      {Key? key, required ResetPasswordBloc resetPasswordBloc})
      : _resetPasswordBloc = resetPasswordBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider.value(
          value: _resetPasswordBloc,
          child: Padding(
            padding: EdgeInsets.all((24)*SizeConfig.screenWidthBase),
            child: ResetPasswordBody(),
          ),
        ),
      ),
    );
  }
}
