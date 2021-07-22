import 'package:flutter/material.dart';
import 'package:aking/widgets/rounded_button.dart';
import 'package:aking/constants.dart';
import 'package:aking/size_config.dart';

import '../../components/form_error.dart';
import '../../components/password_textfield.dart';
import '../../components/username_textfield.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UsernameTextField(),
          SizedBox(height: 30),
          PasswordTextField(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, forgotPasswordPath);
                },
                child: Text(
                  "Forgot password",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(80),
            child: FormError(),
          ),
          RoundedButton(
            text: 'Log In',
            backgroundColor: hexToColor("#F96060"),
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
            textColor: hexToColor("#FFFFFF"),
          ),
        ],
      ),
    );
  }
}
