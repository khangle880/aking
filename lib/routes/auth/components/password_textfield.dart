import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aking/models/providers/user_provider.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userNotifier = context.read<UserProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: Theme.of(context).textTheme.headline6,
        ),
        TextFormField(
          obscureText: true,
          style: Theme.of(context).textTheme.bodyText1,
          onSaved: (newValue) => userNotifier.changePassword(newValue),
          onChanged: (value) {
            userNotifier.validatePassword(value);
          },
          validator: (value) {
            userNotifier.validatePassword(value!);
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Enter your password',
          ),
        ),
      ],
    );
  }
}
