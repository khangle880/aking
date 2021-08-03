import 'package:aking/logic/blocs/reset_password/reset_password_bloc.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/logic/utils/validator/auth_validators.dart';
import 'package:aking/views/utils/modules/auth_module.dart';
import 'package:aking/views/widgets/normal_text_field.dart';
import 'package:aking/views/widgets/obscure_text_field.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _resetCodeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late ResetPasswordBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<ResetPasswordBloc>(context);
  }

  @override
  void dispose() {
    _resetCodeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateOtp(String? input) {
    if (input != null && AuthValidators.isValidOtp(input)) {
      return null;
    } else {
      return "Invalid field";
    }
  }

  String? _validateNewPassword(String? input) {
    if (input != null && AuthValidators.isValidPassword(input)) {
      return null;
    } else {
      return "Invalid field";
    }
  }

  String? _validateConfirmPassword(String? input) {
    if (input != null && _newPasswordController.text == input) {
      return null;
    } else {
      return "Not same new password";
    }
  }

  void _onFormSubmitted() {
    _loginBloc.add(ResetPassWithEmailPressed(
        password: _newPasswordController.text,
        resetCode: _resetCodeController.text));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reset Code',
            style: textTheme.headline6,
          ),
          NormalTextField(
            controller: _resetCodeController,
            validator: _validateOtp,
            hintText: 'Enter your number',
          ),
          SizedBox(height: 30),
          Text(
            'New password',
            style: textTheme.headline6,
          ),
          ObscureTextField(
            controller: _newPasswordController,
            validator: _validateNewPassword,
            hintText: 'Enter your password',
          ),
          SizedBox(height: 30),
          Text(
            'Confirm password',
            style: textTheme.headline6,
          ),
          ObscureTextField(
            controller: _confirmPasswordController,
            validator: _validateConfirmPassword,
            hintText: 'Enter your confirm password',
          ),
          SizedBox(
            height: 80.h,
          ),
          RoundedButton(
            text: 'Change password',
            backgroundColor: hexToColor("#F96060"),
            press: () {
              if (_formKey.currentState!.validate()) {
                _onFormSubmitted();
              }
            },
            textColor: hexToColor("#FFFFFF"),
          ),
          BlocListener<ResetPasswordBloc, ResetPasswordState>(
            listener: (context, state) {
              

              if (state is ResetPasswordFailure) {
                showSnackBar(context, <Widget>[
                  Text(state.errorMessage),
                  Icon(Icons.error),
                ]);
              }

              if (state is ResetPasswordLoading) {
                showSnackBar(
                  context,
                  <Widget>[
                    Text('Resetting...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                  duration: Duration(hours: 1),
                );
              }

              if (state is ResetPasswordSuccess) {
                showSnackBar(
                  context,
                  <Widget>[
                    Text('Reset Password Success'),
                    Icon(Icons.check),
                  ],
                  duration: Duration(microseconds: 500),
                );
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              }
            },
            child: Container(),
          ),
        ],
      ),
    );
  }
}
