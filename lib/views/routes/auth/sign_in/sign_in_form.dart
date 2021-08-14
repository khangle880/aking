import 'package:aking/logic/blocs/authentication/authentication_bloc.dart';
import 'package:aking/logic/blocs/login/login_bloc.dart';
import 'package:aking/logic/utils/modules/color_module.dart';
import 'package:aking/logic/utils/validator/auth_validators.dart';
import 'package:aking/routing/routes.dart';
import 'package:aking/views/utils/modules/auth_module.dart';
import 'package:aking/views/widgets/normal_text_field.dart';
import 'package:aking/views/widgets/obscure_text_field.dart';
import 'package:aking/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? input) {
    if (input != null && AuthValidators.isValidEmail(input)) {
      return null;
    } else {
      return "Invalid email";
    }
  }

  String? _validatePassword(String? input) {
    if (input != null && AuthValidators.isValidPassword(input)) {
      return null;
    } else {
      return "Invalid field";
    }
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        showFailureSnackBar(
          context,
          state.errorMessage,
        );
      }

      if (state is LoginLoading) {
        showLoadingSnackBar(
          context,
          'Logging In...',
        );
      }

      if (state is LoginSuccess) {
        showSuccessSnackBar(
          context,
          'Login Success',
        );
        context.read<AuthenticationBloc>().add(
              AuthenticationLoggedIn(),
            );
        Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      }
    }, builder: (context, state) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: Theme.of(context).textTheme.headline6,
            ),
            NormalTextField(
              controller: _emailController,
              hintText: "Enter your email",
              validator: _validateEmail,
            ),
            SizedBox(height: 30.h),
            Text(
              'Password',
              style: Theme.of(context).textTheme.headline6,
            ),
            ObscureTextField(
                controller: _passwordController,
                hintText: "Enter your password",
                validator: _validatePassword),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                  },
                  child: Text(
                    "Forgot password",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            RoundedButton(
              text: 'Log In',
              backgroundColor: hexToColor("#F96060"),
              press: () {
                if (_formKey.currentState!.validate()) {
                  _onFormSubmitted();
                }
              },
              textColor: hexToColor("#FFFFFF"),
            ),
          ],
        ),
      );
    });
  }
}
