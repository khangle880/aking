import 'package:aking/logic/blocs/reset_password/reset_password_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocProvider.value(
          value: _resetPasswordBloc,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 0),
            child: ResetPasswordBody(),
          ),
        ),
      ),
    );
  }
}
