import 'package:aking/models/blocs/reset_password/reset_password_bloc.dart';
import 'package:aking/routes/auth/reset_password/reset_password_screen.dart';
import 'package:aking/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aking/widgets/rounded_button.dart';
import 'package:aking/size_config.dart';

class ForgotPasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Forgot Password',
        style: Theme.of(context).textTheme.headline4,
      ),
      const Text('', textAlign: TextAlign.left),
      ForgotPasswordForm(),
    ]);
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmailPassword(String? input) {
    if (input != null && _emailController.text == input) {
      return null;
    } else {
      return "Not same new password";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  // ignore: deprecated_member_use
                  autovalidate: true,
                  validator: (_) {
                    return ;
                  },
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        decorationColor: Colors.black.withOpacity(0.01),
                      ),
                  decoration: InputDecoration(
                    hintText: 'Enter The Email',
                  ),
                ),
                SizedBox(height: (30) * SizeConfig.screenHeightBase),
                RoundedButton(
                  text: 'Log In',
                  backgroundColor: hexToColor("#F96060"),
                  press: () {
                    // print("Button Enable: ${isButtonEnabled(state)}");
                    // if (isButtonEnabled(state)) {
                    //   Navigator.pushNamed(context, Routes.resetPasswordRoute,
                    //       arguments: [
                    //         context.read<ResetPasswordBloc>(),
                    //         _emailController.text
                    //       ]);
                    // }
                  },
                  textColor: hexToColor("#FFFFFF"),
                ),
                // },
                // ),
              ],
            ),
          );
        });
  }
}
