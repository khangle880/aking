import 'package:aking/models/blocs/authentication/authentication_bloc.dart';
import 'package:aking/models/blocs/reset_password/reset_password_bloc.dart';
import 'package:aking/utils/auth_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:aking/widgets/rounded_button.dart';
import 'package:aking/size_config.dart';

class ResetPasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Forgot Password',
        style: Theme.of(context).textTheme.headline4,
      ),
      const Text('', textAlign: TextAlign.left),
      ResetPasswordForm(),
    ]);
  }
}

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
        email: _resetCodeController.text,
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
          TextFormField(
            controller: _resetCodeController,
            keyboardType: TextInputType.number,
            // ignore: deprecated_member_use
            autovalidate: true,
            validator: _validateOtp,
            style: textTheme.bodyText1!.copyWith(
              decorationColor: Colors.black.withOpacity(0.01),
            ),
            decoration: InputDecoration(
              hintText: 'Enter your number',
            ),
          ),
          SizedBox(height: 30),
          Text(
            'New password',
            style: textTheme.headline6,
          ),
          TextFormField(
            controller: _newPasswordController,
            obscureText: true,
            // ignore: deprecated_member_use
            autovalidate: true,
            style: textTheme.bodyText1,
            validator: _validateNewPassword,
            decoration: InputDecoration(
              hintText: 'Enter your password',
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Confirm password',
            style: textTheme.headline6,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            // ignore: deprecated_member_use
            autovalidate: true,
            style: textTheme.bodyText1,
            validator: _validateConfirmPassword,
            decoration: InputDecoration(
              hintText: 'Enter your confirm password',
            ),
          ),
          SizedBox(
            height: (80) * SizeConfig.screenHeightBase,
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
              _showSnackBar(context, <Widget>[
                Text(state.errorMessage),
                Icon(Icons.error),
              ]);
            }

            if (state is ResetPasswordLoading) {
              _showSnackBar(
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
              _showSnackBar(
                context,
                <Widget>[
                  Text('Login Success'),
                  Icon(Icons.check),
                ],
                duration: Duration(microseconds: 500),
              );
              context.read<AuthenticationBloc>().add(
                    AuthenticationLoggedIn(),
                  );
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              });
            }
          }),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, List<Widget> children,
      {Duration? duration}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
          backgroundColor: Theme.of(context).accentColor,
          duration: duration ?? Duration(milliseconds: 4000),
        ),
      );
  }
}


// Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () async {
//                     // Navigator.pushReplacementNamed(context, forgotPasswordPath);
//                     // context
//                     //     .read<AuthenticationBloc>()
//                     //     .userRepository
//                     //     // .requestResetPassword(_resetCodeController.text);
//                     //     .resetPassword("182963", "a123123124");
//                     // EmailAuth.sessionName = "Sample";
//                     // await EmailAuth.sendOtp(
//                     //     receiverMail: _resetCodeController.text);

//                     // final String? error = await context
//                     //     .read<AuthenticationBloc>()
//                     //     .userRepository
//                     //     .resetPassword("abc@gmail.com", "a123123321");
//                     // if (error == null)
//                     //   log("Fuckkkkk");
//                     // else
//                     //   log(error);
//                   },
//                   child: Text(
//                     "Forgot password",
//                     style: textTheme.subtitle1,
//                   ),
//                 ),
//               ],
//             ),