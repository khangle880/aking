import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aking/models/providers/auth_error_provider.dart';
import 'package:aking/widgets/rounded_button.dart';
import 'package:aking/size_config.dart';

import '../../components/form_error.dart';

class ForgotPasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Forgot Password',
        style: Theme.of(context).textTheme.headline4,
      ),
      const Text('', textAlign: TextAlign.left),
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => AuthErrorProvider())
      ], child: ForgotPasswordForm()),
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UserName',
            style: Theme.of(context).textTheme.headline6,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              hintText: 'Enter The Username',
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(80),
            child: FormError(),
          ),
          RoundedButton(
            text: 'Send Request',
            backgroundColor: hexToColor("#F96060"),
            press: () {},
            textColor: hexToColor("#FFFFFF"),
          ),
        ],
      ),
    );
  }
}
