import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aking/models/providers/auth_provider.dart';

class UsernameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNotifier = context.read<AuthProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: Theme.of(context).textTheme.headline6,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (newValue) => userNotifier.changeUserName(newValue),
          onChanged: (value) {
            userNotifier.validateUserName(value);
          },
          validator: (value) {
            userNotifier.validateUserName(value!);
            return null;
          },
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                decorationColor: Colors.black.withOpacity(0.01),
              ),
          decoration: InputDecoration(
            hintText: 'Enter The Email',
          ),
        ),
      ],
    );
  }
}
